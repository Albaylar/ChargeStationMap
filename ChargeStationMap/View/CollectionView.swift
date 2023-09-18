//
//  CollectionView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 17.09.2023.
//

import SwiftUI
import MapKit


struct MyCollectionView: View {
    let locations: [ChargeViewModel.ChargeListViewModel]
    @Binding var selectedLocation: ChargeViewModel.ChargeListViewModel?

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(locations) { location in
                    MyCollectionViewCell(location: location, didSelectLocation: {
                        selectedLocation = location // Hücreye tıklandığında seçilen konumu sakla
                    })
                }
            }.padding()
        }
    }
}





