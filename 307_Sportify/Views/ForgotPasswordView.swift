//
//  ForgotPasswordView.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 9/29/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email = "";
    
    var body: some View {
        ZStack {
            
            Color.black.ignoresSafeArea()
            
            Text("Input your associated account email")
                .foregroundColor(.white)
                .offset(CGSize(width: 0, height: -55))
            
            TextField("Email", text: $email)
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: 0))
            
            // submit button
            Button("Submit") {
                
                // TODO - submit button
                
            }
            .foregroundColor(.black)
            .fontWeight(.heavy)
                .frame(width: 225, height: 50)
                .background(Color("SportGold"))
                .cornerRadius(200)
                .offset(CGSize(width: 0, height: 75))
            
        }
    }
}

#Preview {
    ForgotPasswordView()
}
