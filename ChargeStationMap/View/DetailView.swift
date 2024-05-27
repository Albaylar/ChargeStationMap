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
    var destinationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: location.latitude ?? 0.0, longitude: location.longitude ?? 0.0)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .center, spacing: 10) {
                    Text(location.addressTitle ?? "Bilinmeyen İşletme")
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                    
                    VStack(alignment: .center, spacing: 5) {
                        Label("Adres:", systemImage: "map")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(red: 0, green: 0.6, blue: 0))

                        Text(location.address ?? "Bilgi yok")
                            .font(.system(size: 15, weight: .regular))
                            
                    }
                    
                    VStack(alignment: .center, spacing: 5) {
                        Label("Bağlantı Türleri:", systemImage: "powerplug")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(red: 0, green: 0.6, blue: 0))
                        Text(location.ConnectionType.joined(separator: ", "))
                            .font(.system(size: 15, weight: .regular))
                    }
                    
                    HStack(spacing: 15) {
                        
                        VStack(alignment: .center) {
                            Label("Town:", systemImage: "house")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color(red: 0, green: 0.6, blue: 0))

                            Text(location.town ?? "Bilgi yok")
                                .font(.system(size: 15, weight: .regular))
                        }
                        
                        VStack(alignment: .center) {
                            Label("City:", systemImage: "building")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color(red: 0, green: 0.6, blue: 0))

                            Text(location.city ?? "Bilgi yok")
                                .font(.system(size: 15, weight: .regular))
                            
                        }
                    }
                    
                    VStack(alignment: .center, spacing: 5) {
                        Label("Postal Code:", systemImage: "envelope")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(red: 0, green: 0.6, blue: 0))

                        Text(location.postalCode ?? "Bilgi yok")
                            .font(.system(size: 15, weight: .regular))

                        
                    }
                    
                    VStack(alignment: .center, spacing: 5) {
                        Label("Usage Type:", systemImage: "person.fill")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(red: 0, green: 0.6, blue: 0))

                        Text(location.charge.usageType?.title ?? "Bilgi yok")
                            .font(.system(size: 15, weight: .regular))

                    }
                    
                    VStack(alignment: .center, spacing: 5) {
                        Label("Socket Type:", systemImage: "powerplug")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(red: 0, green: 0.6, blue: 0))

                        Text(location.CurrentType.joined(separator: ","))
                            .font(.system(size: 15, weight: .regular))

                    }
                    
                    VStack(alignment: .center, spacing: 5) {
                        Label("Phone:", systemImage: "phone")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(red: 0, green: 0.6, blue: 0))

                        if let contactNumber = location.charge.addressInfo?.contactTelephone1,
                           let telURL = URL(string: "tel:\(contactNumber)") {
                            Link(destination: telURL) {
                                HStack {
                                    Image(systemName: "phone")
                                    Text("Ara: \(contactNumber)")
                                        .font(.system(size: 15, weight: .regular))

                                }
                            }
                        } else {
                            Text("Ara: Bilgi yok")
                        }
                    }
                    
                    MapAppLauncher(destination: destinationCoordinate, charge: location)
                    
                    // MapView
                    MapView(coordinate: destinationCoordinate)
                        .frame(height: UIScreen.main.bounds.height * 0.3)
                        .cornerRadius(20)
                        .shadow(radius: 1)

                    Spacer() // Tüm içeriği merkeze hizalamak için Spacer ekle
                    
                }
                .padding()
                
            }
            
            
        }
        
        .navigationBarTitle("Şarj İstasyonu Detayları", displayMode: .inline)
        .background(Color(red: 0.99, green: 0.99, blue: 0.96))
        .foregroundColor(.black)
        
    }
    
}


struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.isUserInteractionEnabled = false 
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        uiView.setRegion(region, animated: true)
        
        // Önceki pinleri temizle
        uiView.removeAnnotations(uiView.annotations)
        
        // Yeni pin ekle
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        uiView.addAnnotation(annotation)
    }
}














