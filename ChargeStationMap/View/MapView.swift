//
//  MapView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 18.09.2023.
//

import SwiftUI
import _MapKit_SwiftUI

struct MapView: View {
    @Binding var region: MKCoordinateRegion
    @Binding var userTrackingMode: MapUserTrackingMode
    var annotations: [ChargeViewModel.ChargeListViewModel]
    @Binding var selectedAnnotation: ChargeViewModel.ChargeListViewModel?

    var body: some View {
        Map(
            coordinateRegion: $region,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: annotations
        ) { charge in
            MapMarker(
                coordinate: CLLocationCoordinate2D(latitude: charge.latitude ?? 0.0, longitude: charge.longitude ?? 0.0),
                tint: .green
            )
            .overlay(
                Button(action: {
                    // Tıklandığında yapılacak işlemler
                    selectedAnnotation = charge
                }) {
                    // İsteğe bağlı, tıklanabilir bir görünüm ekleyebilirsiniz
                    Text("Tıkla")
                        .foregroundColor(.blue)
                }
            )


        }
        .onTapGesture {
            selectedAnnotation = nil
        }
        .ignoresSafeArea()
    }
}


