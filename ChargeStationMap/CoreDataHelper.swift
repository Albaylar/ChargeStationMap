//
//  CoreDataHelper.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 25.12.2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    static let shared = CoreDataHelper()

    private init() {}

    // Context'i al
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // Favori istasyonu ekle
    func addFavoriteStation(stationId: Int) {
        let favoriteStation = FavoriteStation(context: context)
        favoriteStation.stationId = stationId

        do {
            try context.save()
        } catch {
            print("Error saving favorite station: \(error.localizedDescription)")
        }
    }

    // Favori istasyonunu kaldır
    func removeFavoriteStation(stationId: Int) {
        let fetchRequest: NSFetchRequest<FavoriteStation> = FavoriteStation.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "stationId == %d", stationId)

        do {
            let result = try context.fetch(fetchRequest)
            guard let firstObject = result.first else { return }
            context.delete(firstObject)
            try context.save()
        } catch {
            print("Error removing favorite station: \(error.localizedDescription)")
        }
    }
}
