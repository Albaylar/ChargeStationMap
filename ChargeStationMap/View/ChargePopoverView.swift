//
//  ChargePopoverView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 24.12.2023.
//

import SwiftUI

struct ChargePopoverView: View {
    var charge: ChargeViewModel.ChargeListViewModel
    var onDismiss: () -> Void
    @EnvironmentObject var viewModel: ChargeViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(charge.addressTitle ?? "No name")
                .font(.headline)
                .padding(.top)

        }
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.13)
        .background(Color(red: 0, green: 0.5, blue: 0))
        .foregroundColor(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}













