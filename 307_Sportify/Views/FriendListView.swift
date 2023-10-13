//
//  FriendListView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 10/7/23.
//

import SwiftUI

struct FriendListView: View {
    @ObservedObject var otherUsers = AllUsers()
    
    
    var body: some View {
        NavigationView {
            List(otherUsers.users) { users in
                NavigationLink(destination: DetailsView(person: users)){
                    Text(users.name)
                }
            } .navigationBarTitle("Friends")
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
                print("FRIEND ADDED")
            }
        }
    }
}
