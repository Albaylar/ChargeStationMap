//
//  ChargeViewModel.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 17.09.2023.
//

import SwiftUI
import MapKit
import CoreLocation

class ChargeViewModel : ObservableObject {
    
    @Published var favoriteStations: [Int] = []
    @Published private var locationManager = CLLocationManager()
    @Published var stationList = [ChargeListViewModel]()
    @Published var userTrackingMode: MapUserTrackingMode = .follow
    @Published var selectedRegion  = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    @Published var selectedLocation: ChargeListViewModel?
    @StateObject var viewModel = ChargeViewModel()
    @Published var popoverStates: [PopoverState] = []
    private var webService = WebService()
    @Published var currentCoordinate: CLLocationCoordinate2D?
    @Published var isDetailViewActive = false 

    
    func fetchData() async {
        var resource = ""
        if webService.type == "WebService" {
            if #available(iOS 16, *) {
                resource = Constants.urls.userExtension
            } else {
            }
        } else {
            resource = Constants.paths.baseURL
        }
        
        do {
            let users = try await webService.download(resource)
            self.stationList = users.map(ChargeListViewModel.init)
        } catch let error as NSError {
            print("Error: \(error)")
        }
        
        do {
            let savedFavoriteStations = try await fetchFavoriteStations()
            self.favoriteStations = savedFavoriteStations
        } catch {
            print("Error fetching favorite stations: \(error)")
        }
        
        self.popoverStates = self.stationList.map { PopoverState(chargeId: $0.id ?? 0, isShowing: false) }
    }
    

    func fetchFavoriteStations() async throws -> [Int] {
        guard let savedFavoriteStations = UserDefaults.standard.array(forKey: "FavoriteStations") as? [Int] else {
            throw NetworkError.invalidServiceResponese
        }
        return savedFavoriteStations
    }

    func contains(_ stationId: Int) -> Bool {
        return favoriteStations.contains(stationId)
    }
    
    func add(_ stationId: Int) {
        DispatchQueue.main.async {
            if !self.favoriteStations.contains(stationId) {
                self.favoriteStations.insert(stationId, at: 0)
                print("Favorilere eklendi: \(self.favoriteStations)")
                self.save()
            } else {
                print("İstasyon zaten favorilerde.")
            }
        }
    }
    
    func remove(_ stationId: Int) {
        DispatchQueue.main.async {
            self.favoriteStations.removeAll { $0 == stationId }
            print("Favorilerden kaldırıldı: \(self.favoriteStations)")
            self.save()
        }
    }
    
    func save() {
        UserDefaults.standard.set(favoriteStations, forKey: "FavoriteStations")
    }
    
    func filteredStations(_ searchText: String) -> [ChargeListViewModel] {
        return stationList.filter { charge in
            let stateMatches = charge.charge.addressInfo?.stateOrProvince?.contains(searchText) ?? false
            let operatorMatches = charge.addressTitle?.contains(searchText) ?? false
            let town = charge.town?.contains(searchText) ?? false
            let postCode = charge.postalCode?.contains(searchText) ?? false
            // dört kriteri bir arada kontrol etmek için &&
            return stateMatches || operatorMatches || town || postCode
        }
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.locationServicesEnabled() {
            let status = self.locationManager.authorizationStatus
            if status == .denied || status == .restricted {
                print("Kullanıcı izini reddetti.")
            } else {
                switch status {
                case .authorizedWhenInUse, .authorizedAlways:
                    self.userTrackingMode = .follow
                case .notDetermined:
                    self.locationManager.requestWhenInUseAuthorization()
                default:
                    break
                }
            }
        } else {
            
        }
    }
    
    func selectLocation(_ location: ChargeListViewModel) {
        self.selectedLocation = location
        if let latitude = location.latitude, let longitude = location.longitude {
            self.selectedRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        }
    }
    
    func convertTextToLocation(_ searchText: String, completion: @escaping (CLLocation?) -> Void) {
        let geocoder = CLGeocoder()
        // Senaryo 1: Koordinatları doğrudan girildi
        if let coordinate = parseCoordinate(from: searchText) {
            completion(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
            return
        }
        geocoder.geocodeAddressString(searchText) { placemarks, error in
            if let error = error {
                print("Geocode error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            if let placemark = placemarks?.first {
                if let location = placemark.location {
                    completion(location)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func parseCoordinate(from text: String) -> CLLocationCoordinate2D? {
        let components = text.components(separatedBy: CharacterSet(charactersIn: ", "))
        guard components.count == 2,
              let latitude = Double(components[0]),
              let longitude = Double(components[1])
        else {
            return nil
        }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    

    func loadStationsNearby(coordinate: CLLocationCoordinate2D, radius: Double) {
        Task {
            do {
                let stations = try await webService.loadStations(coordinate: coordinate, radius: radius)
                DispatchQueue.main.async {
                    self.stationList = stations.map(ChargeListViewModel.init)
                }
            } catch {
                print("Error loading stations: \(error)")
            }
        }
    }

    struct ChargeListViewModel : Identifiable ,Equatable {
        static func == (lhs: ChargeListViewModel, rhs: ChargeListViewModel) -> Bool {
            return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
        }
        
        let charge : ChargeElement
        var id : Int? {
            charge.id
        }
        var websiteURL : String? {
            charge.dataProvider?.websiteURL
        }
        var address : String? {
            charge.addressInfo?.addressLine1
        }
        var latitude : Double? {
            charge.addressInfo?.latitude
        }
        var longitude : Double? {
            charge.addressInfo?.longitude
        }
        var addressTitle : String? {
            charge.addressInfo?.title
        }
        var operatortitle : String? {
            charge.operatorInfo?.title
        }
        var ConnectionType: [String] {
            var types: [String] = []
            if let connections = charge.connections {
                for connection in connections {
                    if let connectionType = connection.connectionType {
                        if let title = connectionType.title {
                            types.append(title)
                        }
                    }
                }
            }
            return types
        }
        var CurrentType: [String] {
            var types: [String] = []
            if let connections = charge.connections {
                for connection in connections {
                    if let currentType = connection.currentType {
                        if let title = currentType.title {
                            types.append(title)
                        }
                    }
                }
            }
            return types
        }

        
        var city : String? {
            charge.addressInfo?.stateOrProvince
        }
        var town : String? {
            charge.addressInfo?.town
        }
        var postalCode : String? {
            charge.addressInfo?.postcode
        }
    }
}






