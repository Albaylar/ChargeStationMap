//
//  NetworkService.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 17.09.2023.
//

import Foundation


protocol NetworkService {
    func download(_ resources: String) async throws -> [ChargeElement]
    var type: String { get }
}
