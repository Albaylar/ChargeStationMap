import SwiftUI
import CoreLocation
import MapKit
import Combine
import GoogleMobileAds
import AppTrackingTransparency

struct ContentView: View {
    @StateObject var viewModel = ChargeViewModel()
    @State private var selectedTab = 0
    @StateObject private var interstitialAdManager = InterstitialAdsManager()
    @State private var selectedLocation: ChargeViewModel.ChargeListViewModel?
    @State private var showingDetail = false
    @State private var showAd = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    CustomTabBarView(selectedTab: selectedTab)
                        .environmentObject(viewModel)
                        .accentColor(Color(red: 0, green: 0.6, blue: 0, opacity: 1))
                }
            }
            .sheet(isPresented: $showingDetail) {
                if let selectedLocation = selectedLocation {
                    DetailView(location: selectedLocation)
                }
            }
            .onAppear {
                interstitialAdManager.loadInterstitialAdIfNeeded()
                NotificationCenter.default.addObserver(forName: .interstitialAdDidDismiss, object: nil, queue: .main) { _ in
                    
                    if selectedLocation != nil {
                        showingDetail = true
                    }
                }
            }
            .onChange(of: interstitialAdManager.interstitialAdLoaded) { loaded in
                if loaded && showAd {
                    showAd = false
                    interstitialAdManager.displayInterstitialAd()
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchData()
            }
        }
    }
}



struct MapViewContainer: View {
    @ObservedObject var viewModel = ChargeViewModel()
    @State private var searchText = ""
    @ObservedObject var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    @State private var initialRegion: MKCoordinateRegion?
    @State private var noResultsMessage = "Şarj İstasyonu bulunamadı."
    @State private var showAlert = false
    @State private var userTrackingMode: MapUserTrackingMode = .none
    @State private var location: CLLocation?
    @State private var isSearchBarActive = false
    @State private var selectedLocation: ChargeViewModel.ChargeListViewModel?
    @State private var showingDetail = false
    @State private var showAd = false
    @StateObject private var interstitialAdManager = InterstitialAdsManager()

    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.selectedRegion,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode,
                annotationItems: viewModel.stationList) { charge in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: charge.latitude ?? 0.0, longitude: charge.longitude ?? 0.0)) {
                    VStack {
                        Button(action: {
                            if let index = viewModel.popoverStates.firstIndex(where: { $0.chargeId == charge.id }) {
                                viewModel.popoverStates[index].isShowing.toggle()
                            }
                        }) {
                            Image("thunder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.green)
                        }
                        if let popoverState = viewModel.popoverStates.first(where: { $0.chargeId == charge.id }), popoverState.isShowing {
                            ChargePopoverView(
                                charge: charge,
                                onDismiss: {
                                    if let index = viewModel.popoverStates.firstIndex(where: { $0.chargeId == charge.id }) {
                                        viewModel.popoverStates[index].isShowing = false
                                    }
                                }
                            )
                            .position(x: UIScreen.main.bounds.width / 3, y: 40)
                        }
                    }
                }
            }
                .padding(.bottom, UIScreen.main.bounds.height * 0.10)
                .sheet(isPresented: $showingDetail) {
                    if let selectedLocation = selectedLocation {
                        DetailView(location: selectedLocation)
                    }
                }
                .onTapGesture {
                    isSearchBarActive = false
                    viewModel.hideKeyboard()
                }
                .ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(height: UIScreen.main.bounds.width * 0.03)
                Button(action: {
                    if let userLocation = locationManager.userLocation {
                        region.center = userLocation
                        viewModel.selectedRegion = region
                        userTrackingMode = .follow
                    }
                }) {
                    Image(systemName: "location.fill")
                        .foregroundColor(Color(red: 0, green: 0.6, blue: 0))
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .offset(x: UIScreen.main.bounds.width / 2.5, y: UIScreen.main.bounds.height / 1.4)
                .padding(.all)
                HStack {
                    TextField("Şarj istasyonu için konum giriniz                    ", text: $searchText)
                        .onTapGesture {
                            isSearchBarActive = true
                        }
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color(.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.5)))
                .foregroundColor(.black)
                .cornerRadius(75)
                .frame(width: UIScreen.main.bounds.height * 0.4)
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
                    .padding()
                
                if isSearchBarActive || searchText.isEmpty {
                    EmptyView()
                } else {
                    let filteredStations = viewModel.filteredStations(searchText)
                    if filteredStations.isEmpty {
                        
                        VStack {
                            Text(noResultsMessage)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.green)
                                .padding(.all, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color.green, lineWidth: 8)
                                )
                                .background(Color.white)
                                .cornerRadius(50)
                                .shadow(radius: 5)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                        }
                    } else {
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(filteredStations) { location in
                                    MyCollectionViewCell(location: location) {
                                        selectedLocation = location
                                        if interstitialAdManager.interstitialAdLoaded {
                                            showAd = true
                                            interstitialAdManager.displayInterstitialAd()
                                        } else {
                                            showingDetail = true
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 7)
                        .sheet(isPresented: $showingDetail, content: {
                            if let selectedLocation = selectedLocation {
                                DetailView(location: selectedLocation)
                            }
                        })
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
        }
        .onChange(of: searchText) { newSearchText in
            if newSearchText.isEmpty {
                if let userLocation = locationManager.userLocation {
                    region.center = userLocation
                    viewModel.selectedRegion = region
                    userTrackingMode = .follow
                }
            } else {
                viewModel.convertTextToLocation(newSearchText) { location in
                    if let location = location {
                        self.location = location
                        region.center = location.coordinate
                        viewModel.selectedRegion = region
                    }
                }
            }
        }
        .onReceive(Just(searchText)) { newSearchText in
            if newSearchText.isEmpty {
                if let initialRegion = initialRegion {
                    region = initialRegion
                    viewModel.selectedRegion = region
                }
            } else {
                viewModel.convertTextToLocation(newSearchText) { location in
                    if let location = location {
                        self.location = location
                        region.center = location.coordinate
                        viewModel.selectedRegion = region
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchData()
                DispatchQueue.main.async {
                    if let userLocation = locationManager.userLocation {
                        region.center = userLocation
                        userTrackingMode = .follow
                    }
                }
            }
            interstitialAdManager.loadInterstitialAdIfNeeded()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
