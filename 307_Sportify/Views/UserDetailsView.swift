//
//  UserDetailsView.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/13/23.
//

import SwiftUI
import Firebase

class userDetailsControl: UIViewController {
    
}

struct UserDetailsView: View {
    //@Binding var userID: String // passed in when profile is clicked on
    @State var userID = "1"// testing
    @State var userAuth = UserAuthentication()
    @State private var profilePic: Image = Image("DefaultProfile")
    @State private var ref = Database.database().reference()
    @State var user: User = User(id: "ERROR", name: "ERROR", email: "ERROR", radius: 0, zipCode: "ERROR", sportsPreferences: [], privateAccount: false, profilePicture: "ERROR", age: 0, birthday: Date(), friendList: [], blockList: [], eventsAttending: [], eventsHosting: [], suggestions: [], notifications: [], messageList: [])

    //@State var user: User
    
    // the user we are viewing - delete after done testing - use ^^
    //@State var user = User(id: "1", name: "AK", email: "ak@gmail.com", radius: 1, zipCode: "47906", sportsPreferences: [2], privateAccount: false, profilePicture: "", age: 21, birthday: Date(), friendList: [], blockList: [], eventsAttending: [], eventsHosting: [])

    var body: some View {
        @State var currentUser = userAuth.currUser
        //@State var currentUser = User(id: "2", name: "Andrew", email: "andrew@gmail.com", radius: 1, zipCode: "47906", sportsPreferences: [0], privateAccount: false, profilePicture: "", age: 21, birthday: Date(), friendList: [], blockList: [], eventsAttending: [], eventsHosting: [])
        
        ZStack {
            Color.black.ignoresSafeArea()
                .onAppear(perform: { // get the user from the DB based on ID passed in
                    ref.child("Users").child(userID).getData(completion: { error, snapshot in
                        guard error == nil else {
                            print(error!.localizedDescription)
                            return
                        }
                        user = snapshot?.value as? User ?? User(id: "ERROR", name: "ERROR", email: "ERROR", radius: 0, zipCode: "ERROR", sportsPreferences: [], privateAccount: false, profilePicture: "ERROR", age: 0, birthday: Date(), friendList: [], blockList: [], eventsAttending: [], eventsHosting: [], suggestions: [], notifications: [], messageList: []);
                    });
                });
            
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
                if (currentUser != nil) {
                    if (currentUser!.isBlocked(userID: user.id)) { // unwrap
                        Button("Unblock") {
                            Task {
                                currentUser!.unblockUser(unblockUserID: user.id)
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
                                currentUser!.blockUser(blockUserID: user.id)
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

