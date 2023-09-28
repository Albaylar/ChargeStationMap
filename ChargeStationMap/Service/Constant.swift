//
//  Constant.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 17.09.2023.
//
import Foundation

struct Constants {
    
    struct paths {
        static let baseURL = "key=6b2ff8b8-d4d8-4854-82e4-3131a0c36d7b"
    }
    
    
    struct urls {
        static let baseURL = "https://api.openchargemap.io/v3/poi/?output=json&countrycode=TR&maxresults=1000&"
        static let userExtension = "\(baseURL)key=6b2ff8b8-d4d8-4854-82e4-3131a0c36d7b"
        //  static let userExtension = "\(baseURL)/users"
        // static let userExtension = "\(baseURL)/users"
        //static let userExtension = "\(baseURL)/users"
        
        
    }
    
}
