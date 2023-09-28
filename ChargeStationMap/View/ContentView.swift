import SwiftUI
import CoreLocation
import MapKit
import Combine

struct ContentView: View {
    @ObservedObject var viewModel = ChargeViewModel()
    @State private var searchText = ""
    @ObservedObject var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )
    @State private var initialRegion: MKCoordinateRegion? // Başlangıç Noktası
    @State private var noResultsMessage = "Şarj İstasyonu bulunamadı."
    @State private var showAlert = false
    @State private var userTrackingMode: MapUserTrackingMode = .none
    @State private var location: CLLocation?
    @State private var isSearchBarActive = false
    @State private var selectedLocation: ChargeViewModel.ChargeListViewModel?
    @State var userLocation: CLLocationCoordinate2D?



    var body: some View {
        NavigationView {
            ZStack {
                Map(
                    coordinateRegion: $region,
                    showsUserLocation: true,
                    userTrackingMode: $userTrackingMode,
                    annotationItems: viewModel.stationList
                ) { charge in
                    MapMarker(
                        coordinate: CLLocationCoordinate2D(latitude: charge.latitude ?? 0.0, longitude: charge.longitude ?? 0.0),
                        tint: .green
                    )
                }
                .onTapGesture {
                    isSearchBarActive = false // Haritaya tıkladığınızda arama çubuğunu kapatın
                    viewModel.hideKeyboard()
                }
                .ignoresSafeArea()
                

                VStack {
                    Spacer()
                        .frame(height: 30)
                    HStack {
                        TextField("Şarj istasyonu için konum giriniz                    ", text: $searchText)
                            .onTapGesture {
                                isSearchBarActive = true
                            }
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color(.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.6)))
                    .foregroundColor(.black)
                    .cornerRadius(75)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.08)
                    .foregroundColor(.black)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Geçersiz Konum"),
                            message: Text("Lütfen geçerli bir konum girin."),
                            dismissButton: .default(Text("Tamam"))
                        )
                    }
                    Spacer()
                        .frame(maxWidth: .infinity)
                        .padding(.all)

                    if isSearchBarActive || searchText.isEmpty {
                        EmptyView()
                    } else {
                        let filteredStations = viewModel.filteredStations(searchText)
                        if filteredStations.isEmpty {
                            // Sonuçlar boşsa mesajı göster
                            
                            VStack {
                                Text(noResultsMessage)
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .foregroundColor(.green)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 50)
                                            .stroke(Color.green, lineWidth: 8)
                                    )
                                    .background(Color.white)
                                    .cornerRadius(50) // Beyaz kutuyu da yuvarlak köşeli yapabilirsiniz
                                    .shadow(radius: 10)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                            }
                            
                                
                        } else {
                            // Sonuçlar bulunursa koleksiyonu göster
                            MyCollectionView(locations: filteredStations, selectedLocation: $selectedLocation)
                                .frame(width: UIScreen.main.bounds.width * 0.98, height: UIScreen.main.bounds.height * 0.30)
                                
                        }
                            
                    }

                }
            }
            .onChange(of: searchText) { newSearchText in
                if newSearchText.isEmpty {
                    // Eğer searchText boşsa, kullanıcının konumuna dönün
                    if let userLocation = locationManager.userLocation {
                        region.center = userLocation
                        userTrackingMode = .follow
                    }
                } else {
                    // Değilse, arama metni değeri kullanılarak konumu güncelle
                    viewModel.convertTextToLocation(newSearchText) { location in
                        if let location = location {
                            self.location = location
                            region.center = location.coordinate
                        }
                    }
                }
            }
            
            .onReceive(Just(searchText)) { newSearchText in
                if newSearchText.isEmpty {
                    // Eğer searchText boşsa, mevcut merkezi kullanarak haritayı güncelle
                    if let initialRegion = initialRegion {
                        region = initialRegion
                    }
                } else {
                    // Değilse, arama metni değeri kullanılarak konumu güncelle
                    viewModel.convertTextToLocation(newSearchText) { location in
                        if let location = location {
                            self.location = location
                            region.center = location.coordinate
                        }
                    }
                }
            }
            .onAppear {
                viewModel.checkLocationAuthorizationStatus()
                Task {
                    await viewModel.fetchData()
                }
                // Başlangıçta harita merkezini kullanıcının konumuna ayarlayın
                if let userLocation = locationManager.userLocation {
                    region.center = userLocation
                    userTrackingMode = .follow
                }
            }

        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
