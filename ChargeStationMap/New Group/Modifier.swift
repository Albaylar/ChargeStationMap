//
//  Modifier.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 16.05.2024.
//

import SwiftUI

struct CustomViewModifier: ViewModifier {
    @Binding var show: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            InterstitialAdView()
                .isHidden(!show)
        }
        
    }
}

extension View {
    public func addMob(show: Binding<Bool>) -> some View {
        self
            .modifier(CustomViewModifier(show: show))
    }
}

extension View {
    @ViewBuilder
    func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }
}


