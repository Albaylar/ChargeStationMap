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

    @State private var initialRegion: MKCoordinateRegion? // Başlangıçta harita merkezini saklamak için bir değişken ekleyin
    @State private var isKeyboardVisible = false

    @State private var showAlert = false
    @State private var userTrackingMode: MapUserTrackingMode = .none
    @State private var location: CLLocation?
    @State private var isSearchBarActive = false
    @State private var selectedLocation: ChargeViewModel.ChargeListViewModel?
    @State private var searchThreshold = 3

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
                    hideKeyboard()
                }
                
                .ignoresSafeArea()
                

                VStack {
                    HStack {
                        TextField("Search                          ", text: $searchText)
                            .padding(.trailing, 10)
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
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.05)
                    .padding([.leading, .bottom, .trailing])
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
                    }else{
                        
                        MyCollectionView(locations: viewModel.filteredStations(searchText), selectedLocation: $selectedLocation)
                            .frame(width: UIScreen.main.bounds.width * 0.98, height: UIScreen.main.bounds.height * 0.35)
                            .padding()
                    }


                }
            }
            .onChange(of: selectedLocation) { newLocation in
                if let location = newLocation {
                    region.center = CLLocationCoordinate2D(latitude: location.latitude ?? 0.0, longitude: location.longitude ?? 0.0)
                    userTrackingMode = .follow
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
                // Başlangıçta harita merkezini kaydet
                initialRegion = region
            }
        }
    }

    private func hideKeyboard() {
        // Klavyeyi gizlemek için kod burada olacak
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
