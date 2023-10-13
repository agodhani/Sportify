//
//  MyFriends.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 10/13/23.
//

import SwiftUI
import Firebase

struct MyFriends: View {
    @EnvironmentObject var userAuth: UserAuthentication
    var body: some View {
        let currUser = userAuth.currUser
        var id = currUser?.id ?? ""
        var myfriends = currUser?.friendList ?? []
        var friends = [Friend]()
        VStack {
            ForEach(myfriends, id: \.self) {myfriends in
                Text(myfriends)
                    .padding()
            }
        }.navigationBarTitle("My Friends")
      /*  NavigationView{
            List(friends){ friends in
                Text(friends.name)
            }
        } .navigationBarTitle("My Friends")
            .onAppear(){
                getFriends(friends: myfriends, id: id)
            }
        */
    }
}

struct Friend: Identifiable {
    var name: String
    var id: String
}

func getFriends(friends: [String], id: String){
    for friend in friends {
        Friend(name: friend, id: id);
    }
}

#Preview {
    MyFriends()
}
