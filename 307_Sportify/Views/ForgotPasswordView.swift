//
//  ForgotPasswordView.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 9/29/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email = "";
    @EnvironmentObject var userAuth: UserAuthentication
    
    var body: some View {
        ZStack {
            
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("Input your associated account email")
                    .foregroundColor(.white)
                    .padding()
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                
                // submit button
                Button("Submit") {
                    Task {
                        try await userAuth.forgotPasswordFindEmail(email: email)
                    }
                    
                }
                .foregroundColor(.black)
                .fontWeight(.heavy)
                    .frame(width: 225, height: 50)
                    .background(Color("SportGold"))
                    .cornerRadius(200)
                    .padding()
            }
            .offset(CGSize(width: 0, height: -20))
        }
    }
}

#Preview {
    ForgotPasswordView()
}
