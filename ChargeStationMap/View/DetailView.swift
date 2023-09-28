//
//  DetailView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 18.09.2023.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let location: ChargeViewModel.ChargeListViewModel
    
    var body: some View {
        let destinationCoordinate = CLLocationCoordinate2D(
            latitude: location.latitude ?? 0.0,
            longitude: location.longitude ?? 0.0
        )
        
        VStack(alignment:.center) {
            Text("Detaylar")
                .font(.largeTitle)
                .foregroundColor(.green)
                .bold()
        }
        
        VStack(alignment: .leading, spacing: 15) {
            
                Text(location.operatortitle ?? "")
                    .font(.title2)
                    .foregroundColor(Color.blue)
                    .bold()
            
            HStack{
                Text("Adres : ")
                    .bold()
                Text("\(location.address ?? "")")
                    .font(.body)
            }
            
            
            Text("Bağlantı Türleri: \(location.ConnectionType.joined(separator: ", "))")
                .font(.body)
            
            HStack {
                Text("Town:")
                    .bold()
                Text(location.town ?? "")
                
                Text("City:")
                    .bold()
                Text(location.city ?? "")
            }
            
            Text("Postal Code : \(location.postalCode ?? "There is no postacode info.")")
            
            Text("Usage Type : \(location.charge.usageType?.title ?? "There is no usage type info.")")
            
            Text("Website : \(location.websiteURL ?? "There is no website info.")")
            
            HStack{
                Text("Telephone Number:")
                Link(destination: URL(string: "tel:\(location.charge.addressInfo?.contactTelephone1 ?? "")")!) {
                    Text(location.charge.addressInfo?.contactTelephone1 ?? "")
                        .foregroundColor(.blue)
                }
                
            }
            
            VStack {
                    
                MapAppLauncher(destination: destinationCoordinate, charge: location)
                    .padding(.leading,50) // Gerektiğinde sağdan boşluk bırakabilirsiniz
                    
                }
            
                GoogleMapsAppLauncher(destination: destinationCoordinate, charge: location)
                    .padding(.leading,25) // Ekranda dikeyde merkezlenmiş olacaktır
            
        }
        .font(.system(size: 20))
        .padding()
        .cornerRadius(20)
        .shadow(radius: 10)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.green, lineWidth: 4)
        )
    }
}


