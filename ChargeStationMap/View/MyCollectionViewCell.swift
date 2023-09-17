//
//  MyCollectionViewCell.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 17.09.2023.
//

import SwiftUI

import SwiftUI
import MapKit

struct MyCollectionViewCell: View {
    let location: ChargeViewModel.ChargeListViewModel
    let didSelectLocation: () -> Void

    var body: some View {
        Button(action: {
            didSelectLocation()
        }) {
            VStack {
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
                
                Spacer()
                Image(systemName: "location.fill")
                    .foregroundColor(.blue)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.green, lineWidth: 4))
        }
    }
}


