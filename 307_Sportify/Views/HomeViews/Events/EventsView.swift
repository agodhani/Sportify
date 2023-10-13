//
//  EventsView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 9/30/23.
//

import SwiftUI

struct EventsView: View {
    
    @State var userAuth = UserAuthentication()
    @State var eventsm = EventMethods()
    // how to get the current user? TODO change this once figured out
    @State var createEvent = false
    @State var editEvent = false
    var body: some View {
        @State var currentUser = userAuth.currUser
        
        //@State var allEvents = userAuth.currUser?.getAllEvents() // TODO uncomment this THIS NEEDS TO BE A SET OF EVENTS NOT A SET OF STRINGS
        
        
        //let allEvents: [Event] = [testEvent, testEvent2, testEvent3] // TODO
        
        ZStack (alignment: .top) {
            Color.black.ignoresSafeArea()
            
            VStack (alignment: .center) {
                
                /*Text(currentUser.id) // trying to see the currentUser ID
                    .foregroundColor(.white)*/
                
                Text("MY EVENTS")
                    .foregroundColor(Color("SportGold"))
                    .background(.black)
                    //.offset(CGSize(width: 0, height: -350))
                    .font(.system(size: 40, weight: .heavy, design: .default))
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 250, height: 10)
                    .cornerRadius(10.0)
                    .padding(1)
                    .offset(CGSize(width: 0, height: -20))
                
                HStack (spacing: 40) {
                    
                    Text("Event/Capacity") // default font size is 17
                    //Text("Capacity")
                    
                    Text("Sport")
                    
                    Text("Location")
                    
                    Text("Date")
                    
                }
                .padding(10)
                .background(Color.sportGold).frame(width: 500)
                .frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                
                Button("Create Event") {
                    createEvent = true
                }.foregroundColor(.black)
                    .fontWeight(.heavy)
                    .frame(width: 225, height: 50)
                    .background(Color("SportGold"))
                    .cornerRadius(200)
                    .offset(CGSize(width: 0, height: 0))
                
                Button("Edit Event") {
                    editEvent = true
                }.foregroundColor(.black)
                    .fontWeight(.heavy)
                    .frame(width: 225, height: 50)
                    .background(Color("SportGold"))
                    .cornerRadius(200)
                    .offset(CGSize(width: 0, height: 0))
                
                Button("Join Event") {
                    // for this to work you need to plug in a valid id
                    /*
                    Task{
                        eventsm.deleteEvent(eventID: "3F592D4E-09E6-4EC1-B15A-735792E27798")
                    }
                     */
                    
                    Task {
                        var user = userAuth.currUser
                        user?.joinEvent(eventID: "0EA0ACAD-03B0-402B-860F-DE6E7D846A32", user: user!)
                    }
                }.foregroundColor(.black)
                    .fontWeight(.heavy)
                    .frame(width: 225, height: 50)
                    .background(Color("SportGold"))
                    .cornerRadius(200)
                    .offset(CGSize(width: 0, height: 0))
                // Scroll View here TODO
                ScrollView {
                    
                    VStack {
                        /*
                        ForEach(allEvents, id: \.eventHostID) { event in
                                
                            // label everything
                            
                            HStack (alignment: .firstTextBaseline, spacing: 18) {
                                
                                VStack { // Event / Capacity
                                    
                                    // Event
                                    let eventName = event.eventName
                                    Text(eventName)
                                        .foregroundColor(.white)
                                        .font(.system(size: 23, weight: .heavy, design: .default))
                                    
                                    
                                    // Capacity
                                    let eventAttendees = event.numAttendees
                                    let eventMaxParticipants = event.maxParticipants
                                    let eventCapacity = String(eventAttendees) + "/" + String(eventMaxParticipants)
                                    
                                    // private / public
                                    if event.privateEvent {
                                        Text("Private " + eventCapacity)
                                            .foregroundColor(.white)
                                            .font(.system(size: 17, weight: .heavy, design: .default))
                                            .padding(.leading, 20)
                                            .padding(.top, -10)
                                    }
                                }
                                
                                
                                // Sport
                                let eventSport = event.sport // this is an int
                                // convert int to the actual sport
                                let sportString = event.sportsList[eventSport]
                                
                                Text(sportString)
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .heavy, design: .default))
                                
                                
                                // Location TODO - int? string?
                                let eventLocation = event.location // zip code ? TODO
                                Text("""
                                 Temp
                                 Location
                                 """)
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .heavy, design: .default))
                                .multilineTextAlignment(.center)
                                
                                
                                VStack {
                                    // Date
                                    let eventDate = event.date.formatted()
                                    
                                    // split into day (0) and time (1)
                                    let eventArr = eventDate.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
                                    let dateStr = String(eventArr[0] + "\n" + eventArr[1])
                                    Text(dateStr)
                                        .foregroundColor(.white)
                                        .font(.system(size: 14, weight: .heavy, design: .default))
                                        .multilineTextAlignment(.center)
                                    
                                    
                                    // manage button TODO
                                    if(currentUser != nil){
                                        if event.userIsEventHost(user: currentUser!) {
                                            Button("Manage") {
                                            action: do {
                                                // TODO SAME AS VIEW - will change inside of SingleEventView accordingly
                                                
                                            }
                                            }
                                            .foregroundColor(.black)
                                            .fontWeight(.heavy)
                                            .frame(width: 75, height: 30)
                                            .background(Color("SportGold"))
                                            .cornerRadius(200)
                                            .font(.system(size: 13, weight: .heavy, design: .default))
                                        } else {
                                            Button("View") {
                                            action: do {
                                                // TODO SAME AS MANAGE - will change inside of SingleEventView accordingly
                                            }
                                            }
                                            .foregroundColor(.black)
                                            .fontWeight(.heavy)
                                            .frame(width: 75, height: 30)
                                            .background(Color("SportGold"))
                                            .cornerRadius(200)
                                            .font(.system(size: 13, weight: .heavy, design: .default))
                                        }
                                    }
                                }
                            }
                         
                            
                            // bottom border
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 450, height: 2)
                                .padding(1)
                        }
                         */
                    }
                }

                
            /*
                Rectangle()
                    .fill(.white)
                    .frame(height: 300)
                
                Rectangle()
                    .fill(.white)
                    .frame(height: 300)*/
                

            }
            if(createEvent) {
                CreateEvent()
            }
            if(editEvent) {
                EditEventView()
            }
        }
        
        
        /*
        Color.black.ignoresSafeArea()
                
            
            Image(systemName: "calendar.badge.clock")
                    .foregroundColor(.green)
                    .font(.system(size: 100.0))*/

    }
}

#Preview {
    EventsView()
}
