//
//  MapView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 17.09.2023.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    @Binding var selectedCharge: ChargeListViewModel?
    @Binding var region: MKCoordinateRegion
    var stations: [ChargeListViewModel] // Değişiklik: stations dizisi olarak güncelle
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    // ... Diğer metotlar ...
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        // Pin üzerine tıklanınca çağrılacak metot
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            // Seçilen pin ile ilişkilendirilmiş şarj istasyonunu alın
            if let coordinate = view.annotation?.coordinate {
                if let selectedCharge = parent.stations.first(where: { charge in
                    return charge.latitude == coordinate.latitude && charge.longitude == coordinate.longitude
                }) {
                    parent.selectedCharge = selectedCharge
                }
            }
        }

        // Pin'den ayrıldığında çağrılacak metot
        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            // Seçili şarj istasyonunu temizle
            parent.selectedCharge = nil
        }
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Harita bölgesini güncelle
        uiView.setRegion(region, animated: true)

        // Şarj istasyonlarını haritaya ekleyin
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(stations.map { charge in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: charge.latitude ?? 0.0, longitude: charge.longitude ?? 0.0)
            annotation.title = charge.addressTitle // Title'ı burada ayarla
            return annotation
        })
    }

}

