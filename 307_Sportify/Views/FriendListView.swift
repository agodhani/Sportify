//
//  FriendListView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 10/7/23.
//

import SwiftUI
import Firebase

class friendController: UIViewController {
    
}

struct FriendListView: View {
    @ObservedObject var otherUsers = AllUsers()
    @State var locationFilter: Bool
    @State var userAuth = UserAuthentication()
    @State var profView = false;

    
    var body: some View {
        let user = userAuth.currUser
        VStack{
            NavigationView {
                List(otherUsers.users) { users in
                    if(locationFilter) {
                        if(user?.zipCode == users.zipCode) {
                            NavigationLink(destination: DetailsView(person: users)) {
                                Text(users.name)
                            }
                        }
                    } else {
                        NavigationLink(destination: DetailsView(person: users)) {
                            Text(users.name)
                        }
                    }
                } .navigationBarTitle("Potential Friends")
                    .onAppear() {
                        otherUsers.getUsers()
                    }
            }
            Spacer()
            Toggle("Location Filter", isOn: $locationFilter).foregroundColor(Color("SportGold"))
                .frame(width: 300, height: 50)
            Button("Back") {
                profView = true
                print("clicked")
            }
            .frame(width: 300, height: 50)
        }
    }
}

#Preview {
    FriendListView(locationFilter: true)
}

struct DetailsView: View {
    let person: Person
    @EnvironmentObject var userAuth: UserAuthentication
    var body: some View {
        var currUser = userAuth.currUser
        VStack(alignment: .leading) {
            Text(person.name).font(.largeTitle)
            Button("Add Friend"){
                currUser?.addFriend(userID: person.id)
                var userid = currUser?.id
                let db = Firestore.firestore()
                db.collection("Users").document(userid!)
                    .updateData(["friendList": currUser?.friendList])
                print("FRIEND ADDED")
                
            }
        }
    }
}
