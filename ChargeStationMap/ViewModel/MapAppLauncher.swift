//
//  MapAppLauncher.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 18.09.2023.

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
            HStack {
                Image(systemName: "location.fill")
                    .foregroundColor(.white)
                Text("Navigate to location")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color(red: 0, green: 0.6, blue: 0))
            .cornerRadius(30)
        }
    }
    
    private func openInAppleMaps() {
        let placemark = MKPlacemark(coordinate: destination)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = charge.addressTitle
        mapItem.openInMaps(launchOptions: nil)
    }
}


