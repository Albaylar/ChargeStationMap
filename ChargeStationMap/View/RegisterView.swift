//
//  RegisterView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 21.12.2023.
//


import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingLoginView = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            
            Image("Charge")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.2)
                .cornerRadius(30)
            
            TextField("Please Enter an email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal, 50)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            SecureField("Please Enter a password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal, 50)
            
            Button("Register") {
                registerUser()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(25)
            .padding(.horizontal, 70)
            
            Button("Have you registered before?") {
                showingLoginView = true
            }
            .foregroundColor(.red)
            .sheet(isPresented: $showingLoginView) {
                LoginView()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Registration Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    private func registerUser() {
        guard isValidEmail(email) else {
            alertMessage = "Invalid email format"
            showAlert = true
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                alertMessage = "Error registering user: \(error.localizedDescription)"
                showAlert = true
            } else {
                print("User registered successfully")
                showingLoginView = true
            }
        }
    }
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

