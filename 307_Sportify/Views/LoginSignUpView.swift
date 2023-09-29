//
//  LoginView.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 9/28/23.
//

import SwiftUI

struct LoginSignUpView: View {
    var body: some View {
        NavigationView {
            //aligns to the top
            ZStack(alignment: .top) {
                Color.black.ignoresSafeArea()
                //logo
                Image("SportifyLogoOriginal")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 200)
                    .padding(.vertical, 64)
                //login button
                Button("LOG IN") {
                    
                } 
                .foregroundColor(.black)
                .fontWeight(.heavy)
                    .frame(width: 225, height: 50)
                    .background(Color("SportGold"))
                    .cornerRadius(200)
                    .offset(CGSize(width: 0, height: 400.0))
                //signup button
                Button("SIGN UP") {
                    
                }
                .foregroundColor(.black)
                .fontWeight(.heavy)
                    .frame(width: 225, height: 50)
                    .background(.gray)
                    .cornerRadius(200)
                    .offset(CGSize(width: 0, height: 475.0))
                

                    
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginSignUpView()
}
