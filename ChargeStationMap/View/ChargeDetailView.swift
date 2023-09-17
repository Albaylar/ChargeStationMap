//
//  ChargeDetailView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 17.09.2023.
//

import SwiftUI

struct ChargeDetailView: View {
    let charge: ChargeViewModel.ChargeListViewModel

    var body: some View {
        VStack {
            Text("Charge Detail View")
                .font(.largeTitle)
                .padding()

            Text("Title: \(charge.addressTitle ?? "")")
                .padding()

            Text("Address: \(charge.address ?? "")")
                .padding()

            Text("Latitude: \(charge.latitude ?? 0.0)")
                .padding()

            Text("Longitude: \(charge.longitude ?? 0.0)")
                .padding()

            Spacer()
        }
    }
}


struct ChargeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChargeDetailView()
    }
}
