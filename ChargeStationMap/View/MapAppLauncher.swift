//
//  MapAppLauncher.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 18.09.2023.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapAppLauncher: View {
    let destination: CLLocationCoordinate2D
    let charge: ChargeViewModel.ChargeListViewModel

    var body: some View {
        Button(action: {
            openInAppleMaps()
        }) {
            Image(systemName: "location.fill")
                .foregroundColor(.blue)
        }
    }

    private func openInAppleMaps() {
        let placemark = MKPlacemark(coordinate: destination)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = charge.addressTitle
        mapItem.openInMaps(launchOptions: nil)
    }
}


