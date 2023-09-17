//
//  MapView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 17.09.2023.
//
/*
import SwiftUI
import MapKit

struct MapView: View {
    @Binding var selectedAnnotation: MKPointAnnotation?
    
    var body: some View {
        Map(
            coordinateRegion: .constant(MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Örnek bir konum
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )),
            showsUserLocation: true,
            userTrackingMode: .constant(.follow),
            annotationItems: [selectedAnnotation].compactMap { $0 }
        ) { annotation in
            MapPin(coordinate: annotation.coordinate, tint: .blue)
                .onTapGesture {
                    selectedAnnotation = annotation
                }
        }
    }
}
*/
