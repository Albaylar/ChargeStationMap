//
//  UserAuthViewModel.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 21.12.2023.
//

import Foundation
import FirebaseAuth


class UserAuthViewModel: ObservableObject {
    @Published var isUserAuthenticated: Bool = true
    
    
    init() {
        self.isUserAuthenticated = Auth.auth().currentUser != nil
    }
    func signOut() {
        self.isUserAuthenticated = false

        do {
            try Auth.auth().signOut()
            print("Signed out successfully")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

}
