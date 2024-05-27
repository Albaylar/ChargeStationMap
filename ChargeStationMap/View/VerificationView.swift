//
//  VerificationView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 21.12.2023.
//

import SwiftUI
import FirebaseAuth

struct VerificationView: View {
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Text("Email Verification")
                .font(.title)
                .bold()
                .padding()

            Text("Please check your email for a verification link. If you haven't received it, you can tap the button below to resend the email.")
                .multilineTextAlignment(.center)
                .padding()

            Button("Resend Verification Email") {
                resendVerificationEmail()
            }
            .padding()
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Info"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func resendVerificationEmail() {
        Auth.auth().currentUser?.sendEmailVerification { error in
            if let error = error {
                alertMessage = "Error resending verification email: \(error.localizedDescription)"
            } else {
                alertMessage = "Verification email resent successfully"
            }
            showingAlert = true
        }
    }
}

#Preview {
    VerificationView()
}
