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
    @State private var zipCode = "";
    @State private var SignUp = false
    @State private var sportView = false
    @State private var sports = Sport.sportData()
    @State private var selectedSports = Set<UUID>()
    @State private var isPrivate = false;
    @EnvironmentObject var userAuth: UserAuthentication
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.black.ignoresSafeArea()
                Image("SportifyLogoOriginal")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 200)
                
                Spacer()
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                    .offset(CGSize(width: 0, height: 200))
                
                
                TextField("Full Name", text: $fullName)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                    .offset(CGSize(width: 0, height: 275))
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                    .offset(CGSize(width: 0, height: 350))
                //NavigationLink(destination:HomePageView()) {
                //Sign UP button
                Spacer()
                TextField("Zipcode", text: $zipCode)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                    .offset(CGSize(width: 0, height: 425))
                Toggle("Private Account", isOn: $isPrivate).foregroundColor(Color("SportGold"))
                    .frame(width: 300, height: 50)
                    .offset(CGSize(width: 0, height: 475))
                
                Button("Upload Profile Picture:") {
                    
                }
                .background(Color.blue)
                .frame(width: 200, height: 50)
                .clipShape(Rectangle())
                .cornerRadius(200)
                .offset(CGSize(width: -100, height: 525))
                Button("Select Sport Preferences:") {
                    sportView = true;
                }
                .background(Color.gray)
                .frame(width: 200, height: 50)
                .clipShape(Rectangle())
                .cornerRadius(10)
                .offset(CGSize(width: 0, height: 575))
                
                
                Button("SIGN UP") {
                    Task {
                        if try await userAuth.createUser(withEmail: email, password: password, fullname: fullName, privateAccount: isPrivate, zipCode: zipCode) {
                            SignUp = true;
                        }
                    }
                }
                
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .frame(width: 225, height: 50)
                .background(Color("SportGold"))
                .cornerRadius(200)
                .offset(CGSize(width: 0, height: 650))
                Spacer()
                if(SignUp) {
                    HomePageView()
                }
                if(sportView) {
                    SportPreferences(selectedSports: $selectedSports)
                }
            }
                
                
            }
            
            
    }
    
}

#Preview {
    SignUpView()
}
