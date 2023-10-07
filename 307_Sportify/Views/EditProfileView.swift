//
//  EditProfileView.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/4/23.
//

import SwiftUI

struct EditProfileView: View {
    @State private var newUsername = ""
    @State private var newPassword = ""
    @State private var newLocation = ""
    
    var body: some View {
        VStack {
            Color.black
            Image("DefaultProfile")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .cornerRadius(200)
                .clipShape(Circle())
                .padding()
            
            TextField("New Username", text: $newUsername)
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: 50))
            
            TextField("New Password", text: $newPassword)
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: 50))
            
            TextField("New Locarion", text: $newLocation)
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: 50))
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Update Profile")
            })
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .frame(width: 225, height: 50)
                .background(Color("SportGold"))
                .cornerRadius(200)
                .offset(CGSize(width: 0, height: 200))
        }
    }
}

#Preview {
    EditProfileView()
}
