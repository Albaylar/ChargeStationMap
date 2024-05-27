//
//  SettingsView.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 22.12.2023.
//
import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject var userAuthViewModel: UserAuthViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var isDarkMode = false
    @State private var showingFeedbackSheet = false
    @State private var showingLanguageSelection = false
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle(isOn: $isDarkMode) {
                    Text("Dark Mode")
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    showingFeedbackSheet = true
                }) {
                    Text("Feedback/Support")
                }
                .padding()
                
                Text("About Us/Help")
                    .padding()
                
                Spacer()
                
                Button(action: {
                    userAuthViewModel.signOut()
                    
                    if !userAuthViewModel.isUserAuthenticated {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            print("Navigating to RegisterView...")
                            let rootViewController = UIApplication.shared.windows[0].rootViewController
                            rootViewController?.dismiss(animated: true)
                        }
                    }
                }) {
                    Text("Çıkış Yap")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.06)
                        .background(Color.red)
                        .cornerRadius(30)
                        .padding()
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .sheet(isPresented: $showingFeedbackSheet) {
                FeedbackView()
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


