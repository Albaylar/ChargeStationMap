//
//  CoreDataModel.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 18.12.2023.
//

import Foundation

import CoreData

class FavoriteStation: NSManagedObject {
    @NSManaged var stationId: Int64
    // Add other properties as needed

    // You may also need to add relationships or other properties based on your specific requirements

    // Convenience initializer if needed
    convenience init(stationId: Int64, context: NSManagedObjectContext) {
        self.init(context: context)
        self.stationId = stationId
        // Initialize other properties as needed
        
    }
}

// You may need to add more to this model based on your specific requirements
