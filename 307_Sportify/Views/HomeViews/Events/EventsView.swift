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
    @State var viewEvent = false
    @State var viewSingleEvent = false
    @State var allEvents: [String] = [String]()
    @State var allEventsAsEvents: [Event] = [Event]()
    @State var singleEventViewID: String = ""

    var body: some View {
        
        // TODO HERE??? for some reason currentUser keeps becoming NIL - after this figured out, unwrap everything labeled unwrap
        //var currentUser = userAuth.currUser
        @State var currentUser = User(id: "UhbWVV0lTbRd8aY4j4BhVtcyVgo1", name: "test current user", email: "current@gmail.com", radius: 0, zipCode: "47906", sportsPreferences: [], privateAccount: false, profilePicture: "ERROR", age: 0, birthday: Date(), friendList: [], blockList: [], eventsAttending: ["005861C7-AB71-48EF-B17A-515E88AA0D4B"], eventsHosting: []) // REAL - comment


        //let allEvents: [Event] = [testEvent, testEvent2, testEvent3] // TODO
        
        ZStack (alignment: .top) {
            Color.black.ignoresSafeArea()
            
            Button("Create Event") {
                createEvent = true
            }.foregroundColor(.black)
                .font(.system(size: 15, weight: .heavy, design: .default))
                .frame(width: 110, height: 30)
                .background(Color("SportGold"))
                .cornerRadius(200)
                .offset(CGSize(width: 125, height: -30))
                .controlSize(.mini)
            
            VStack (alignment: .center) {
                
                /*Text(currentUser.id) // trying to see the currentUser ID
                    .foregroundColor(.white)*/
                
                Text("MY EVENTS")
                    .foregroundColor(Color("SportGold"))
                    .background(.clear)
                    //.offset(CGSize(width: 0, height: -350))
                    .font(.system(size: 40, weight: .heavy, design: .default))
                    .onAppear {
                        Task (priority: .userInitiated) {
                            if currentUser != nil {
                                allEvents = currentUser.getAllEvents() // unwrap
                                for event in allEvents {
                                    await allEventsAsEvents.append(eventsm.getEvent(eventID: event))
                                }
                                print("Loaded: \(allEventsAsEvents)")
                            } else {
                                while (currentUser == nil) {
                                    currentUser = userAuth.currUser!
                                    print("trying to get current user...")
                                }
                                allEvents = currentUser.getAllEvents() // unwrap
                                for event in allEvents {
                                    await allEventsAsEvents.append(eventsm.getEvent(eventID: event))
                                }
                                print("Loaded: \(allEventsAsEvents)")
                            }

                        }
                    }
                
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
                                
                /*
                Button("Edit Event") {
                    editEvent = true
                }.foregroundColor(.black)
                    .fontWeight(.heavy)
                    .frame(width: 225, height: 50)
                    .background(Color("SportGold"))
                    .cornerRadius(200)
                    .offset(CGSize(width: 0, height: 0))
                
                Button("View Event") {
                    // for this to work you need to plug in a valid id
                    /*
                    Task{
                        eventsm.deleteEvent(eventID: "3F592D4E-09E6-4EC1-B15A-735792E27798")
                    }
                     
                     Task {
                         var user = userAuth.currUser
                         user?.joinEvent(eventID: "0EA0ACAD-03B0-402B-860F-DE6E7D846A32", user: user!)
                     }
                     */
                    viewEvent = true;

                }.foregroundColor(.black)
                    .fontWeight(.heavy)
                    .frame(width: 225, height: 50)
                    .background(Color("SportGold"))
                    .cornerRadius(200)
                    .offset(CGSize(width: 0, height: 0))*/
                
                // Scroll View here TODO
                ScrollView {
                    
                    VStack {
                        
                        ForEach(allEventsAsEvents, id: \.self) { event in
                                                            
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
                                    let eventCapacity = "\(eventAttendees) / \(eventMaxParticipants)"
                                    
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
                                /*Text("""
                                 Temp
                                 Location
                                 """)*/
                                Text(eventLocation)
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
                                    if(userAuth.currUser != nil){
                                        if event.userIsEventHost(user: userAuth.currUser!) {
                                            Button("Manage") {
                                            action: do {
                                                singleEventViewID = event.id
                                                viewSingleEvent = true
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
                                                singleEventViewID = event.id
                                                viewSingleEvent = true
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
            if(viewEvent) {
                ViewEventsListView()
            }
            if(viewSingleEvent) {
                SingleEventView(eventid: singleEventViewID)
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
