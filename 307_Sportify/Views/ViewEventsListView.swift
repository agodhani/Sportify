//
//  ViewEventsListView.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/13/23.
//

import SwiftUI
import Firebase

struct ViewEventsListView: View {
    @ObservedObject var allEvents = AllEvents()

    
    var body: some View {
        ZStack {
            
            NavigationView {
                List(allEvents.events) { event in
                    NavigationLink(destination: SingleEventView(eventid: event.id)) {
                        Text(event.name)
                    }
                    
                }
            } .navigationBarTitle("All Events")
                .onAppear(){
                    allEvents.getEvents()
                }
        }
    }
}

#Preview {
    ViewEventsListView()
}
/*
 struct EventDetailsView: View {
 let eventView: EventHighLevel
 @EnvironmentObject var userAuth: UserAuthentication
 var body: some View {
 var currUser = userAuth.currUser
 VStack(alignment: .leading) {
 Text(event.name).font(.largeTitle)
 Button("Add Friend"){
 currUser?.addFriend(name: event.name)
 var userid = currUser?.id
 let db = Firestore.firestore()
 db.collection("Users").document(userid!)
 .updateData(["friendList": currUser?.friendList])
 print("FRIEND ADDED")
 
 }
 }
 }
 }
 */
