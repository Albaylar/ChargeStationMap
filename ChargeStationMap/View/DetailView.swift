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
        VStack {
            Text("Detaylar")
                .font(.title)
                .padding(.bottom, 10)
            
            Text("Adres: \(location.address ?? "")")
                .font(.headline)
                .padding(.bottom, 5)
            
            Text("Bağlantı Türleri: \(location.ConnectionType.joined(separator: ", "))")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            Text("Town of Charge Station : \(location.town ?? "")")
            
            // İstediğiniz diğer ayrıntıları burada görüntüleyebilirsiniz
            // Örneğin, telefon numarası, çalışma saatleri, vb.
            
            Spacer()
        }
        .padding()
    }
}
