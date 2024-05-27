//
//  ParentView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 4.12.2023.
//

import SwiftUI


struct ParentView: View {
    @StateObject private var viewModel = ChargeViewModel() // or however you create your ChargeViewModel
    
    var body: some View {
        VStack {
            MyCollectionView(locations: viewModel.stationList, selectedLocation: $viewModel.selectedLocation)
        }
        .environmentObject(viewModel)
    }
}

