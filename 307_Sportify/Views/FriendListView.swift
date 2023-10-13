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
                VStack(alignment: .leading){
                    Text(users.name).font(.title)
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
