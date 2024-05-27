
//
//  ChargeStationMapApp.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 17.09.2023.
//

import SwiftUI
import FirebaseCore
import GoogleMobileAds



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      GADMobileAds.sharedInstance().start()

    return true
  }
}

@main
struct ChargeStationMapApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var userAuthViewModel = UserAuthViewModel()
    @StateObject private var chargeViewModel = ChargeViewModel()

    var body: some Scene {
        WindowGroup {
            if userAuthViewModel.isUserAuthenticated {
                ContentView()
                    .environmentObject(userAuthViewModel)
                    .environmentObject(chargeViewModel)
            } else {
                RegisterView()
                    .environmentObject(chargeViewModel)
                    .environmentObject(userAuthViewModel)
            }
        }
    }
}






