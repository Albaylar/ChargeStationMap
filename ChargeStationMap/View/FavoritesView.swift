//
//  FavoritesView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 3.12.2023.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: ChargeViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.favoriteStations, id: \.self) { stationId in
                    if let station = viewModel.stationList.first(where: { $0.id == stationId }) {
                        NavigationLink(destination: DetailView(location: station)) {
                            HStack {
                                Text(station.addressTitle ?? "")
                                Spacer()
                                Button(action: {
                                    viewModel.remove(stationId)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(Color(red: 0, green: 0.6, blue: 0))
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                if viewModel.favoriteStations.isEmpty {
                    Text("Favorilenmiş istasyonunuz bulunmamaktadır.")
                        .foregroundColor(Color(red: 0, green: 0.6, blue: 0))
                        .padding()

                    
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Favorite Stations")
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear {
                if viewModel.favoriteStations.isEmpty {
                    Task {
                        await viewModel.fetchData()
                    }
                }
            }
        }
    }
}


















