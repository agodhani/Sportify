//
//  LogInView.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 9/29/23.
//

import SwiftUI

struct LogInView: View {
    @State private var email = "";
    @State private var password = "";
    @EnvironmentObject var userAuth: UserAuthentication
    @State private var homeIn = false;
    @State private var showForgotPassword = false;
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                Image("SportifyLogoOriginal")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 200)
                    .padding(.vertical, -250)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                    .offset(CGSize(width: 0, height: 50))
                
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                    .offset(CGSize(width: 0, height: 125))
                
                
                
                //login button
                Button("LOG IN") {
                    Task {
                        if(try await userAuth.signIn(withEmail: email, password: password)) {
                            homeIn = true
                        }
                    }
                }
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .frame(width: 225, height: 50)
                .background(Color("SportGold"))
                .cornerRadius(200)
                .offset(CGSize(width: 0, height: 200))
                
                if(homeIn) {
                    HomePageView()
                }
                
                // Forgot Password Button
                Button("Forgot Password") {
                    showForgotPassword = true;
                }
                .foregroundColor(.sportGold)
                .offset(CGSize(width: 0, height: 250))
                if (showForgotPassword) {
                    ForgotPasswordView()
                }
                
            }
                
            


        }
        
    }
}

#Preview {
    LogInView()
}
