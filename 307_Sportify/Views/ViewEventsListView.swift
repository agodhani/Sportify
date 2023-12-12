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
    @State private var searchTerm = ""
    @State private var promptText = "Event Name"
    @State private var locationFilter = false;
    @State private var sports = 16;
    @State private var sportList = ["Tennis", "Table Tennis", "Volleyball", "Soccer", "Basketball", "Football", "Baseball", "Badminton", "Golf", "Cycling", "Running", "Hockey", "Spikeball", "Handball", "Lacrosse", "Squash", "None"]
    @State private var participantsFilter = 0;
    @State private var eventHostFilter = false;

    var body: some View {
        NavigationView {
            VStack {
                VStack() {
                    Text("Filter By:")
                    
                    Toggle("Location", isOn: $locationFilter).foregroundColor(Color("SportGold"))
                    Toggle("Event Host", isOn: $eventHostFilter).foregroundColor(Color("SportGold"))
                    Picker(selection: $sports, label: Text("Sport")) {
                        ForEach(sportList.indices) { index in
                            Text(sportList[index])
                        }
                    }
                    Picker(selection: $participantsFilter, label: Text("Participants")) {
                        ForEach(0...25, id: \.self) { number in
                                Text("\(number)")
                        }

                        }
                    
                }
                .onChange(of: locationFilter) {
                    if(locationFilter) {
                        promptText = "Location"
                        eventHostFilter = false
                    } else if(!locationFilter && promptText == "Location") {
                        promptText = "Event Name"
                    }
                }
                .onChange(of: eventHostFilter) {
                    if(eventHostFilter) {
                        promptText = "Event Host"
                        locationFilter = false
                    } else if(!eventHostFilter && promptText == "Event Host") {
                        promptText = "Event Name"
                    }
                }
                //stop undoing here
                
                List(searchTerm.isEmpty ? allEvents.events: allEvents.filteredEvents) { event in
                    if(participantsFilter == event.maxParticipants && sports == event.sport) {
                        NavigationLink(destination: SingleEventView(eventid: event.id)) {
                            Text(event.name)
                        }
                    } else if(participantsFilter == event.maxParticipants && sports == 16) {
                        NavigationLink(destination: SingleEventView(eventid: event.id)) {
                            Text(event.name)
                        }
                    } else if(participantsFilter == 0 && sports == event.sport) {
                        NavigationLink(destination: SingleEventView(eventid: event.id)) {
                            Text(event.name)
                        }
                    } else if(participantsFilter == 0 && sports == 16) {
                        NavigationLink(destination: SingleEventView(eventid: event.id)) {
                            Text(event.name)
                        }
                    }
                    
                }
                .searchable(text: $searchTerm, prompt: promptText)
                //essentially chooses what the filter
                .onChange(of: searchTerm) {searchTerm in
                    if(locationFilter) {
                        allEvents.filteredEvents = allEvents.events.filter({event in
                            event.location.lowercased().contains(searchTerm.lowercased()) })
                    } else if(eventHostFilter) {
                        allEvents.filteredEvents = allEvents.events.filter({event in
                            event.eventHost.lowercased().contains(searchTerm.lowercased()) })
                    } else {
                        allEvents.filteredEvents = allEvents.events.filter({event in
                            event.name.lowercased().contains(searchTerm.lowercased()) })
                    }
                    
                }
                .onAppear(){
                    allEvents.getEvents()
                }
                
                
            }.navigationTitle("Events")
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
