//
//  ForgotPasswordView.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 9/29/23.
//

import SwiftUI
import UIKit

struct ForgotPasswordView: View {
    
    @State private var email = "";
    @EnvironmentObject var userAuth: UserAuthentication
    @State private var test = "";
    @State var statusText = "Input your associated account email"
    
    var body: some View {
        
        ZStack {
            
            Color.black.ignoresSafeArea()
            
            VStack {
                Text(statusText)
                    .foregroundColor(.white)
                    .padding()
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                    .textInputAutocapitalization(.never)
                
                // submit button
                Button("Submit") {
                    
                    action: do {
                        
                        Task {
                            //popUp.appear(sender: uiController)
                            do {
                                try await userAuth.forgotPasswordEmail(email: email)
                                statusText = "Email sent! Check your inbox for email"
                            } catch {
                                statusText = "Provided email was not found"
                            }
                        }
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
