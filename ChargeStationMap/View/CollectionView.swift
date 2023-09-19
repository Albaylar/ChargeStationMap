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
    @State private var isDetailSheetPresented = false // Detay görünümünü açık veya kapalı izlemek için

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(locations) { location in
                    MyCollectionViewCell(location: location, didSelectLocation: {
                        selectedLocation = location // Hücreye tıklandığında seçilen konumu sakla
                        isDetailSheetPresented = true // Detay görünümünü aç
                    })
                }
            }.padding()
        }
        .sheet(isPresented: $isDetailSheetPresented) {
            // Detay görünümünü burada ekleyin
            // Örnek olarak:
            if let selectedLocation = selectedLocation {
                DetailView(location: selectedLocation)
            }
        }
    }
}





