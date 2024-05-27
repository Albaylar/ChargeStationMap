//
//  InterstitialAdView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 16.05.2024.
//

import SwiftUI


struct InterstitialAdView: View {
    
    // Properties
    @StateObject private var interstitialAdManager = InterstitialAdsManager()
    
    // Body
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            
            VStack{
                Image("admob")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                Spacer()
                
                Button {
                    interstitialAdManager.displayInterstitialAd()
                } label: {
                    Text("Show InterstitialAd")
                        .font(.headline)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.horizontal)
                }
                Spacer()
            }
        }
        .onAppear{
            interstitialAdManager.loadInterstitialAd()
        }
        .disabled(!interstitialAdManager.interstitialAdLoaded)
    }
}

struct InterstitialAdView_Previews: PreviewProvider {
    static var previews: some View {
        InterstitialAdView()
    }
}
