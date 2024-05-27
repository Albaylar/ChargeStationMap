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
    @State private var isDetailSheetPresented = false

    var body: some View {
        ScrollView(.horizontal) {
            VStack(spacing: 20){
                LazyHStack(spacing: 15) {
                    ForEach(locations) { location in
                        MyCollectionViewCell(location: location, didSelectLocation: {
                            selectedLocation = location
                            isDetailSheetPresented = true
                        })
                    }
                }.padding(.leading, 10) 
            }
        }
        
        .sheet(isPresented: $isDetailSheetPresented) {
            if let selectedLocation = selectedLocation {
                DetailView(location: selectedLocation)
            }
        }
    }
}







