//
//  FavoriteManager.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 5.12.2023.
//

import Foundation

class FavoriteManager: ObservableObject, FavoriteManageable {
    @Published var favoriteStations: [Int] = []

    func addFavorite(_ stationId: Int) {
        if !favoriteStations.contains(stationId) {
            DispatchQueue.main.async {
                self.favoriteStations.insert(stationId, at: 0)
                self.saveFavorites()
            }
        }
    }

    func removeFavorite(_ stationId: Int) {
        DispatchQueue.main.async {
            self.favoriteStations.removeAll { $0 == stationId }
            self.saveFavorites()
        }
    }

    private func saveFavorites() {
        UserDefaults.standard.set(favoriteStations, forKey: "FavoriteStations")
    }
}
