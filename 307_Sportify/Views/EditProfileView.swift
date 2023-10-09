//
//  EditProfileView.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/4/23.
//

import SwiftUI

extension Image {
    func style() -> some View {
        self.resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .clipped()
            .overlay() {
                ZStack {
                    Image(systemName: "camera.fill")
                        .foregroundColor(.gray)
                        .offset(x:20, y: 60)
                    
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(.white, lineWidth: 4)
                }
            }
    }
}

struct EditProfileView: View {
    @EnvironmentObject var userAuth: UserAuthentication
    @State private var profilePic: Image = Image("DefaultProfile")
    @State private var newUsername = ""
    @State private var newPassword = ""
    @State private var newLocation = ""
    @State private var profile = false
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                       print("pic button clicked")
                    }) {
                 //       if (userAuth.currUser?.getProfilePic() == nil) {
                        profilePic
                            .style()
                
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 200, height: 200)
//                                .cornerRadius(200)
//                                .clipShape(Circle())
//                        } else {
//                            Image(uiImage: (userAuth.currUser?.getProfilePic())!)
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 200, height: 200)
//                                .cornerRadius(200)
//                                .clipShape(Circle())
//                        }
                    }
                    Spacer()
                }
                //Spacer()
                TextField("New Username", text: $newUsername)
                   // .textFieldStyle(.roundedBorder)
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
                
                TextField("New Location", text: $newLocation)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                    .offset(CGSize(width: 0, height: 50))
                
                Button("Update Profile") {
                    profile = true
                }
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .frame(width: 225, height: 50)
                .background(Color("SportGold"))
                .cornerRadius(200)
                .offset(CGSize(width: 0, height: 100))
            }
            if(profile) {
                ProfileView()
            }
        }
    }
}

#Preview {
    EditProfileView()
}
