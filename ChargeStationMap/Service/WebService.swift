//
//  WebService.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 17.09.2023.
//

import Foundation
import CoreLocation

enum NetworkError : Error {
    case invalidURL
    case invalidServiceResponese
}


class WebService : NetworkService {
    var type: String = "WebService"
    
    func download(_ resources: String) async throws -> [ChargeElement] {
        guard let url = URL(string: resources) else {
            throw NetworkError.invalidURL
        }
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else {
            throw NetworkError.invalidServiceResponese
            }
        
        return try JSONDecoder().decode([ChargeElement].self, from: data)
        
        
    }
    func loadStations(coordinate: CLLocationCoordinate2D, radius: Double) async throws -> [ChargeElement] {
            let urlString = "https://api.example.com/stations?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&radius=\(radius)"
            guard let url = URL(string: urlString) else {
                throw NetworkError.invalidURL
            }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.invalidServiceResponese
            }

            return try JSONDecoder().decode([ChargeElement].self, from: data)
        }
}
