//
//  MapViewDelegate.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 20.03.2024.
//

import Foundation
import MapKit
import SwiftUI

struct MapViewDelegate: UIViewRepresentable {
    var mapView: MKMapView
    var viewModel: ChargeViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.delegate = context.coordinator
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var viewModel: ChargeViewModel
        
        init(viewModel: ChargeViewModel) {
            self.viewModel = viewModel
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            let visibleMapRect = mapView.visibleMapRect
            let visibleCoordinateRegion = mapView.region

            let visibleRegionRadius = CLLocation(latitude: visibleCoordinateRegion.center.latitude, longitude: visibleCoordinateRegion.center.longitude).distance(from: CLLocation(latitude: visibleCoordinateRegion.center.latitude + visibleCoordinateRegion.span.latitudeDelta / 2, longitude: visibleCoordinateRegion.center.longitude + visibleCoordinateRegion.span.longitudeDelta / 2))

            viewModel.loadStationsNearby(coordinate: mapView.centerCoordinate, radius: visibleRegionRadius)
        }
    }
}
