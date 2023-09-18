import SwiftUI
import CoreLocation

struct MyCollectionViewCell: View {
    let location: ChargeViewModel.ChargeListViewModel
    let didSelectLocation : () -> ()

    var body: some View {
        let destinationCoordinate = CLLocationCoordinate2D(
            latitude: location.latitude ?? 0.0,
            longitude: location.longitude ?? 0.0
        )

        VStack {
            Text(location.addressTitle ?? "")
                .font(.headline)
                .foregroundColor(.black)
                
            Text(location.address ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
            Text(location.ConnectionType.joined(separator: ", "))
                .font(.subheadline)
                .foregroundColor(.blue)
                .padding()
            Spacer()
            
            MapAppLauncher(destination: destinationCoordinate, charge: location)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.green, lineWidth: 4)
                .onTapGesture {
                    didSelectLocation() // Hücreye tıkladığınızda didSelectLocation() fonksiyonunu çağırın
                }
        )
    }
}
