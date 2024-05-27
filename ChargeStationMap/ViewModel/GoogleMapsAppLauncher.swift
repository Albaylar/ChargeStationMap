//
//  GoogleMapsAppLauncher.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 27.09.2023.
//
import Foundation
import SwiftUI
import CoreLocation

struct GoogleMapsAppLauncher: View {
    let destination: CLLocationCoordinate2D
    let charge: ChargeViewModel.ChargeListViewModel
    
    var body: some View {
        Button(action: {
            openInGoogleMaps()
        }) {
            HStack {
                Image("googleMaps") 
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width*0.08, height: UIScreen.main.bounds.height*0.035)
                    .foregroundColor(.white)
                
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2))
                Text("Navigate with Google Maps")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.green)
            .cornerRadius(30)
        }
    }
    
    private func openInGoogleMaps() {
        let googleMapsURL = URL(string: "comgooglemaps://?q=\(destination.latitude),\(destination.longitude)&zoom=14&views=traffic")
        if UIApplication.shared.canOpenURL(googleMapsURL!) {
            UIApplication.shared.open(googleMapsURL!, options: [:], completionHandler: nil)
        } else {
            let googleMapsWebURL = URL(string: "https://www.google.com/maps/dir/?api=1&destination=\(destination.latitude),\(destination.longitude)&travelmode=driving")
            UIApplication.shared.open(googleMapsWebURL!, options: [:], completionHandler: nil)
        }
    }
}
