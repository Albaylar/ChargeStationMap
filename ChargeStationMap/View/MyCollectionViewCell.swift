//
//  MyCollectionViewCell.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 17.09.2023.
//


import SwiftUI
import MapKit

struct MyCollectionViewCell: View {
    let location: ChargeViewModel.ChargeListViewModel
    let didSelectLocation: () -> Void

    var body: some View {
        let destinationCoordinate = CLLocationCoordinate2D(
            latitude: location.latitude ?? 0.0,
            longitude: location.longitude ?? 0.0
        )

        return VStack {
            Text(location.addressTitle ?? "")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.bottom, 5)
            Text(location.address ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(location.websiteURL ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(location.ConnectionType.joined(separator: ", "))
            
            MapAppLauncher(destination: destinationCoordinate, charge: location)

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.green, lineWidth: 4)
        )
    }
}



