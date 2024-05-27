//
//  FavoriteStation.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 25.12.2023.
//

import Foundation
import CoreData

@objc(FavoriteStation)
public class FavoriteStation: NSManagedObject {
    @NSManaged public var stationId: Int
}
