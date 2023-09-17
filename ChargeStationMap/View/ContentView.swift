//
//  ContentView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 17.09.2023.
//

import SwiftUI
import CoreLocation
import MapKit
import Combine

struct ContentView: View {
    @ObservedObject var viewModel = ChargeViewModel()
    @State private var selectedAnnotation: ChargeViewModel.ChargeListViewModel?

    @State private var searchText = ""
    @State private var isLoading = true
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005) // Bu değerleri ayarlayarak haritayı daha geniş bir perspektiften gösterebilirsiniz
    )
    @State private var showAlert = false
    @State private var userTrackingMode: MapUserTrackingMode = .none
    @State private var location: CLLocation?
    
    
    
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
                    
                    hideKeyboard() // Haritada herhangi bir yere tıkladığınızda klavyeyi kapatır
                }
                
                .ignoresSafeArea()
                
                VStack {
                    HStack {
                        TextField("Search", text: $searchText)
                            .padding(.trailing, 10) // Arama simgesi ile metin arasına bir boşluk bırakmak için
                        Image(systemName: "magnifyingglass") // Arama simgesi
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color(.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.6)))
                    .foregroundColor(.black)
                    .cornerRadius(75)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.05) // Yüksekliği ayarlayın
                    .padding([.leading, .bottom, .trailing])
                    .foregroundColor(.black)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Geçersiz Konum"),
                            message: Text("Lütfen geçerli bir konum girin."),
                            dismissButton: .default(Text("Tamam"))
                        )
                    }
                    Spacer() // Yükseklik eklemek için Spacer kullanın
                        .frame(maxWidth: .infinity)
                        .padding(.all)
                
                

                
                    MyCollectionView(locations: viewModel.filteredStations(searchText)) { location in
                        // Burada location nesnesini kullanarak latitude ve longitude'a erişebilirsiniz
                        if let latitude = location.latitude, let longitude = location.longitude {
                            // didSelectLocation işlemini burada çağırabilirsiniz
                            self.selectedAnnotation = location
                            region.center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                            
                            // Yeni konuma gitme işlemini başlat
                            userTrackingMode = .follow
                        }
                    }

                    .frame(width: UIScreen.main.bounds.width*0.9,height: UIScreen.main.bounds.height*0.2)

                }
            }
            .onReceive(Just(searchText)) { newSearchText in
                if !newSearchText.isEmpty {
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
                
                Task.init {
                    await viewModel.fetchData()
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


