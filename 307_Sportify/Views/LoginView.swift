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
    
    var body: some View {
        NavigationView {
            VStack {
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
                
                
                NavigationLink(destination: HomePageView()) {
                    //login button
                    Button("LOG IN") {
                        Task {
                            try await userAuth.signIn(withEmail: email, password: password)
                        }
                    }
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                    .frame(width: 225, height: 50)
                    .background(Color("SportGold"))
                    .cornerRadius(200)
                    .offset(CGSize(width: 0, height: 200))
                    
                }
                .padding()
                
                NavigationLink(destination: ForgotPasswordView()) {
                    //forgot password button
                    Button("Forgot Password") {
                        
                    }
                    .foregroundColor(.sportGold)
                    .offset(CGSize(width: 0, height: 175))
                }
                .padding()
                
            }
        }
        
    }
}

#Preview {
    LogInView()
}
