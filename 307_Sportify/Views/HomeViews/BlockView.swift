//
//  FriendListView.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/13/23.
//

import SwiftUI
import Firebase

class blockController: UIViewController {
    
}

struct BlockView: View {
    @ObservedObject var otherUsers = AllUsers()
    
    
    var body: some View {
        NavigationView {
            List(otherUsers.users) { users in
                NavigationLink(destination: DetailsView2(person: users)){
                    Text(users.name)
                }
            } .navigationBarTitle("User List")
                .onAppear(){
                    otherUsers.getUsers()
                }
        }
        }
    }

#Preview {
    BlockView()
}

struct DetailsView2: View {
    let person: Person
    @EnvironmentObject var userAuth: UserAuthentication
    var body: some View {
        var currUser = userAuth.currUser
        VStack(alignment: .leading) {
            Text(person.name).font(.largeTitle)
            
            if (currUser!.isBlocked(userID: person.id)) {
                Button("Unblock User"){
                    currUser?.unblockUser(unblockUserID: person.id)
                    let userid = currUser?.id
                    let db = Firestore.firestore()
                    db.collection("Users").document(userid!)
                        .updateData(["blockList": currUser?.blockList])
                    print("User unblocked!")
                }
            } else {
                Button("Block User"){
                    currUser?.blockUser(blockUserID: person.id)
                    let userid = currUser?.id
                    let db = Firestore.firestore()
                    db.collection("Users").document(userid!)
                        .updateData(["blockList": currUser?.blockList])
                    print("User Blocked!")
                }
            }
            

        }
    }
}
