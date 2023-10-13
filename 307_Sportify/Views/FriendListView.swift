//
//  FriendListView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 10/7/23.
//

import SwiftUI
import Firebase

struct FriendListView: View {
    @ObservedObject var otherUsers = AllUsers()
    
    
    var body: some View {
        NavigationView {
            List(otherUsers.users) { users in
                NavigationLink(destination: DetailsView(person: users)){
                    Text(users.name)
                }
            } .navigationBarTitle("Potential Friends")
                .onAppear(){
                    otherUsers.getUsers()
                }
        }
        }
    }

#Preview {
    FriendListView()
}

struct DetailsView: View {
    let person: Person
    @EnvironmentObject var userAuth: UserAuthentication
    var body: some View {
        var currUser = userAuth.currUser
        VStack(alignment: .leading) {
            Text(person.name).font(.largeTitle)
            Button("Add Friend"){
                currUser?.addFriend(name: person.name)
                var userid = currUser?.id
                let db = Firestore.firestore()
                db.collection("Users").document(userid!)
                    .updateData(["friendList": currUser?.friendList])
                print("FRIEND ADDED")
                
            }
        }
    }
}
