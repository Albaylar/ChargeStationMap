//
//  FeedbackView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 25.03.2024.
//

import SwiftUI

struct FeedbackView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Feedback/Support Form")
                .font(.title)
                .padding()
                        
            Spacer()
            
            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}

