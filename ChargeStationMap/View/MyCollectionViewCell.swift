

import SwiftUI
import CoreLocation

struct MyCollectionViewCell: View {
    @EnvironmentObject var viewModel: ChargeViewModel
    let location: ChargeViewModel.ChargeListViewModel
    let didSelectLocation: () -> ()
    
    var body: some View {
        let destinationCoordinate = CLLocationCoordinate2D(
            latitude: location.latitude ?? 0.0,
            longitude: location.longitude ?? 0.0
        )
        
        Button(action: {
            didSelectLocation() 
        }) {
            VStack {
                HStack {
                    Text(location.addressTitle ?? "")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    // Favorite button
                    if let stationId = location.id {
                        Button(action: {
                            if viewModel.contains(stationId) {
                                viewModel.remove(stationId)
                            } else {
                                viewModel.add(stationId)
                            }
                        }) {
                            Image(systemName: viewModel.contains(stationId) ? "star.fill" : "star")
                                .foregroundColor(viewModel.contains(stationId) ? .green : .gray)
                        }
                        .imageScale(.large)
                        .padding(5)
                    }
                }
                Text(location.address ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .padding(5)
                Text(location.CurrentType.joined(separator: ", "))
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.blue)
                    .padding(5)
                
                MapAppLauncher(destination: destinationCoordinate, charge: location)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(.sRGB, red: 0.0, green: 0.6, blue: 0.0, opacity: 1.0), lineWidth: 3)
                    .onTapGesture {
                        didSelectLocation()
                    }
            )
            .padding(.bottom, 10)
        }
    }
}


