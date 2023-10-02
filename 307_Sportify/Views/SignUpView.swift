//
//  SignUpView.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 9/30/23.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = "";
    @State private var fullName = "";
    @State private var password = "";
    @EnvironmentObject var userAuth: UserAuthentication
    
    var body: some View {
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
            
            TextField("Full Name", text: $fullName)
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: 125))
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: 200))
                //Sign UP button
                Button("SIGN UP") {
                    Task {
                        try await userAuth.createUser(withEmail: email, password: password, fullname: fullName)
                    }
                }
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .frame(width: 225, height: 50)
                .background(Color("SportGold"))
                .cornerRadius(200)
                .offset(CGSize(width: 0, height: 275))
        }
    }
}

#Preview {
    SignUpView()
}
