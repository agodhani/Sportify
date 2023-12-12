//
//  BlockView.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/13/23.
//
// This view will be temporary, since no searching yet

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct OldBlockView: View {
    
    @State var userAuth = UserAuthentication()
    @State var ref: DatabaseReference! = Database.database().reference()
    @State var allUsers = AllUsers()
    @State var userDetailsView = false
    @State var userIDViewing: String = String()
    @State private var db = Firestore.firestore()
    
    //func displayUserList() -> some View {

    //}
    
    func displayBlockedList(currentUser: User) -> some View {
        ForEach(allUsers.users) { user in // allUsers.users.forEach
            
            HStack {
                if !currentUser.isBlocked(userID: user.id) { // display if blocked user
                    Button(user.name) {
                        userIDViewing = user.id
                        userDetailsView = true;
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 25, weight: .heavy, design: .default))
                    .padding(10)
                    .onAppear(perform: {
                        allUsers.getUsers()
                        //allUsersList = allUsers.users
                        //FirebaseApp.configure()
                    })
                }
            }
        }
    }

    var body: some View {
        @State var currentUser = userAuth.currUser
        //@State var currentUser = User(id: "4", name: "Andrew", email: "andrew@gmail.com", radius: 1, zipCode: "47906", sportsPreferences: [0], privateAccount: false, profilePicture: "", age: 21, birthday: Date(), friendList: [], blockList: [], eventsAttending: [], eventsHosting: [])
        
        //@State var allUsersList = [Person]()

        NavigationView {
            
            ZStack (alignment: .top) {
                Color.black.ignoresSafeArea()
                    
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
                            //displayUserList()
                            ForEach(allUsers.users) { user in
                                HStack {
                                    Button(user.name) { // displays all users even if blocked
                                        userIDViewing = user.id
                                        userDetailsView = true;
                                    }
                                    .foregroundColor(.white)
                                    .font(.system(size: 25, weight: .heavy, design: .default))
                                    .padding(10)
                                }
                            }
                        }
                    }
                    .frame(height: 300)
                    
                    Text("Block List")
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
                            displayBlockedList(currentUser: currentUser!)
                        }
                    }
                    
                }
                if (userDetailsView) {
                    UserDetailsView(userID: userIDViewing)
                }
            }
        }
    }
}


#Preview {
    OldBlockView()
}
