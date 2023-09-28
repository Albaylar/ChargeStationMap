

import SwiftUI
import CoreLocation

struct MyCollectionViewCell: View {
    let location: ChargeViewModel.ChargeListViewModel
    let didSelectLocation: () -> ()

    var body: some View {
        let destinationCoordinate = CLLocationCoordinate2D(
            latitude: location.latitude ?? 0.0,
            longitude: location.longitude ?? 0.0
        )
        
        Button(action: {
            didSelectLocation() // Kullanıcı hücreye tıkladığında didSelectLocation işlevini çağır
        }) {
            VStack {
                Text(location.addressTitle ?? "")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(5)
                Text(location.address ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(5)
                Text(location.ConnectionType.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding(5)
                MapAppLauncher(destination: destinationCoordinate, charge: location)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.green, lineWidth: 4)
                    .onTapGesture {
                        didSelectLocation()
                    }
            )
            .padding(.bottom, 10)

        }


        
    }
}

