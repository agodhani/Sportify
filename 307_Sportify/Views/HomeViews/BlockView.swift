//
//  BlockView.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/13/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct BlockView: View {
    
    @State var userAuth = UserAuthentication()
    @State var ref: DatabaseReference! = Database.database().reference()
    

    var body: some View {
        
        var testUser1 = User(id: "1", name: "AK", email: "ak@gmail.com", radius: 1, zipCode: "47906", sportsPreferences: [2], privateAccount: false, profilePicture: "", age: 21, birthday: Date(), friendList: [], otherUsers: [], blockList: [], eventsAttending: [], eventsHosting: [])
        
        var testUser2 = User(id: "2", name: "Josh", email: "josh@gmail.com", radius: 1, zipCode: "47906", sportsPreferences: [0], privateAccount: false, profilePicture: "", age: 21, birthday: Date(), friendList: [], otherUsers: [], blockList: [], eventsAttending: [], eventsHosting: [])
        
        var testUser3 = User(id: "3", name: "Alex", email: "alex@gmail.com", radius: 1, zipCode: "47906", sportsPreferences: [1], privateAccount: false, profilePicture: "", age: 21, birthday: Date(), friendList: [], otherUsers: [], blockList: [], eventsAttending: [], eventsHosting: [])

        //@State var currentUser = userAuth.currUser
        @State var currentUser = User(id: "4", name: "Andrew", email: "andrew@gmail.com", radius: 1, zipCode: "47906", sportsPreferences: [0], privateAccount: false, profilePicture: "", age: 21, birthday: Date(), friendList: [], otherUsers: [], blockList: [testUser1.id], eventsAttending: [], eventsHosting: [])
        
        @State var userList = [testUser1, testUser2, testUser3]
        
        ZStack (alignment: .top) {
            
            Color.black.ignoresSafeArea()
                .onAppear(perform: {
                    //FirebaseApp.configure()
                })
            
            VStack {
                
                Text("User List")
                    .foregroundColor(Color("SportGold"))
                    .background(.black)
                    .font(.system(size: 40, weight: .heavy, design: .default))
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 200, height: 10)
                    .cornerRadius(10.0)
                    .padding(1)
                    .offset(CGSize(width: 0, height: -20))
                
                ScrollView {
                    VStack () {
                        ForEach(userList) { user in
                            HStack {
                                if !currentUser.isBlocked(userID: user.id) {
                                    Button(user.getUsername()) {
                                        // TODO - go into UserDetailsView
                                    }
                                    .foregroundColor(.white)
                                    .font(.system(size: 25, weight: .heavy, design: .default))
                                    .padding(10)
                                }
                            }
                        }
                    }
                }
                .frame(height: 300)
                
                Text("Block List")
                    .foregroundColor(Color("SportGold"))
                    .background(.black)
                    //.offset(CGSize(width: 0, height: -350))
                    .font(.system(size: 40, weight: .heavy, design: .default))
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 200, height: 10)
                    .cornerRadius(10.0)
                    .padding(1)
                    .offset(CGSize(width: 0, height: -20))
                
                ScrollView {
                    VStack () {
                        ForEach(currentUser.blockList.sorted(by: <), id: \.self) { userID in
                        
                            HStack {
                                Button(userID) { // ID of blocked user - TODO change to names from DB
                                    // TODO - go into UserDetailsView of that user
                                }
                                .foregroundColor(.white)
                                .font(.system(size: 25, weight: .heavy, design: .default))
                                .padding(10)
                                //.frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        /*
                        ForEach(currentUser.blockList.sorted(by: <), id: \.self) { userID in
                            // this is causing an error?
                            ref.reference().child("Users").child(userID).observeSingleEvent(of: .value) { snapshot in
                                        if let userData = snapshot.value as? [String: Any] {
                                            // Parse the user data and create a User object
                                            if let user = User(dictionary: userData) {
                                                // Append the user to the userList
                                            }
                                        }
                                    }
                        }*/
                    }
                }
                
            }
        }
    }
}



#Preview {
    BlockView()
}
