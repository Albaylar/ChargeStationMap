//
//  LanguageSelectionView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 25.03.2024.
//

import SwiftUI

struct LanguageSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Select Language")
                .font(.title)
                .padding()
            
            Button(action: {
                // Change app language to English
            }) {
                Text("English")
            }
            .padding()
            
            Button(action: {
                // Change app language to Spanish
            }) {
                Text("Spanish")
            }
            .padding()
            
            Spacer()
            
            Button("Done") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}

