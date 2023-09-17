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
    
    @Published private var locationManager = CLLocationManager()
    @Published var stationList = [ChargeListViewModel]()
    @Published var userTrackingMode: MapUserTrackingMode = .follow
    @Published var selectedRegion  = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
 
    let service = WebService()
    
    
    
    
    func fetchData() async {
        var resource = ""
        if service.type == "WebService" {
            resource = Constants.urls.userExtension
        }
        else {
            resource = Constants.paths.baseURL
        }
        do {
            
            let users = try await service.download(resource)
            
            DispatchQueue.main.async {
                
                self.stationList = users.map(ChargeListViewModel.init)
                
                
                
            }
        }catch let error as NSError {
            print("Error: \(error)")
        }

    }
    func filteredStations(_ searchText: String) -> [ChargeListViewModel] {
        return stationList.filter { charge in
            return charge.addressTitle?.contains(searchText) ?? false
        }
    }
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.locationServicesEnabled() {
            let status = locationManager.authorizationStatus
            if status == .denied || status == .restricted {
                // Konum izni reddedildi veya sınırlıdır. Kullanıcıya açıklama gösterin ve gerekirse Ayarlar uygulamasına yönlendirin.
            } else {
                // Konum izni verilmiş veya henüz verilmemiş.
                switch status {
                case .authorizedWhenInUse, .authorizedAlways:
                    userTrackingMode = .follow
                case .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                default:
                    break
                }
            }
        } else {
            // Konum hizmetleri devre dışı. Kullanıcıya açıklama gösterin.
        }
    }
    func convertTextToLocation(_ searchText: String, completion: @escaping (CLLocation?) -> Void) {
        let geocoder = CLGeocoder()
        
        // Senaryo 1: Koordinatları doğrudan girildi
        if let coordinate = parseCoordinate(from: searchText) {
            completion(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
            return
        }
        
        // Senaryo 2: Adres veya yer ismi girildi
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

    

    // Koordinatları ayrıştırmak için yardımcı bir işlev
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
    func updateMap(with annotations: [ChargeListViewModel], centerCoordinate: CLLocationCoordinate2D) {
        // Haritayı güncelleyin ve yakın yerlere işaretçiler ekleyin
        // region.center'i centerCoordinate ile güncelleyin ve annotationItems'a annotations ekleyin
        self.selectedRegion.center = centerCoordinate
    }

    struct ChargeListViewModel : Identifiable {
        let charge : ChargeElement
        
        var id : Int? {
            charge.id
        }
        var usageCost : String? {
            charge.usageCost
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
        
        
        
        
    }
}
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

