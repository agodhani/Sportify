//
//  UserDetailsView.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/13/23.
//

import SwiftUI

struct UserDetailsView: View {
    
    @State var userAuth = UserAuthentication()
    
    //@EnvironmentObject var user: User // TODO the user we are viewing
    
    // the user we are viewing - delete after done testing - use ^^
    @State var user = User(id: "1", name: "AK", email: "ak@gmail.com", radius: 1, zipCode: "47906", sportsPreferences: [2], privateAccount: false, profilePicture: "", age: 21, birthday: Date(), friendList: [], otherUsers: [], blockList: [], eventsAttending: [], eventsHosting: [])
            
    @State private var profilePic: Image = Image("DefaultProfile")
    

    var body: some View {
        //@State var currentUser = userAuth.currUser
        @State var currentUser = User(id: "2", name: "Andrew", email: "andrew@gmail.com", radius: 1, zipCode: "47906", sportsPreferences: [0], privateAccount: false, profilePicture: "", age: 21, birthday: Date(), friendList: [], otherUsers: [], blockList: [], eventsAttending: [], eventsHosting: [])
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                profilePic
                    .style()
                    /*.onTapGesture {
                        showImagePicker = true
                    }
                    .onChange(of: inputImage) {loadImage()}
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: $inputImage)
                    }*/
                if (currentUser != nil) { // will need to force unwrap
                    if (currentUser.isBlocked(userID: user.id)) { // unwrap
                        Button("Unblock") {
                            Task {
                                currentUser.unblockUser(unblockUserID: user.id) // unwrap
                            }
                        }
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                            .frame(width: 75, height: 30)
                            .background(Color(.red))
                            .cornerRadius(200)
                            .font(.system(size: 13, weight: .heavy, design: .default))
                        
                    } else {
                        Button("Block") {
                            Task {
                                currentUser.blockUser(blockUserID: user.id) // unwrap
                            }
                        }
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                            .frame(width: 75, height: 30)
                            .background(Color(.red))
                            .cornerRadius(200)
                            .font(.system(size: 13, weight: .heavy, design: .default))
                    }
                }

                
                
                
            }
            
            
        }
        
    }
    
    
}

#Preview {
    UserDetailsView()
}

