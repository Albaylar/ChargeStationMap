//
//  LoginPage.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 3.12.2023.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = "furkandenizalbaylar@gmail.com"
    @State private var password: String = "123456789"
    @State private var isLoginSuccessful = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
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

                Button("Sign In") {
                    signIn()
                }
                .padding()
                .background(Color(.sRGB, red: 0.0, green: 0.5, blue: 0.0, opacity: 1.0))
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal, 70)


                // Giriş başarılıysa ContentView'a geçiş
                .fullScreenCover(isPresented: $isLoginSuccessful) {
                    ContentView()
                }
                
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                showingAlert = true
            } else {
                // Giriş başarılı, ContentView'a yönlendir
                isLoginSuccessful = true
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

