//
//  EventsView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 9/30/23.
//

import SwiftUI

struct EventsView: View {
    
    @State var userAuth = UserAuthentication()

    var body: some View {
        //var allEvents = userAuth.currUser?.getAllEvents()
        let testEvent: Event = Event()
        let allEvents: [Event] = [testEvent]
        
        ZStack (alignment: .top) {
            Color.black.ignoresSafeArea()
            
            VStack (alignment: .center) {
                Text("MY EVENTS")
                    .foregroundColor(Color("SportGold"))
                    .background(Color("Black"))
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
                
                // Scroll View here TODO
                ScrollView {
                    
                    VStack {
                        ForEach(allEvents) { event in
                                
                            // label everything
                            
                            HStack (alignment: .firstTextBaseline, spacing: 18) {
                                
                                VStack { // Event / Capacity
                                    
                                    // Event
                                    let eventName = event.eventName
                                    Text(eventName)
                                        .foregroundColor(.white)
                                        .font(.system(size: 23, weight: .heavy, design: .default))
                                    
                                    // private / public
                                    let eventPrivate = event.privateEvent
                                    var privStr = ""
                                    if (eventPrivate) {
                                        let privStr = "Private"
                                    } else {
                                        let privStr = "Public"
                                    }
                                    Text(privStr)
                                        .foregroundColor(.white)
                                        .font(.system(size: 17, weight: .heavy, design: .default))
                                    
                                    // Capacity
                                    let eventAttendees = event.numAttendees
                                    let eventMaxParticipants = event.maxParticipants
                                    let eventCapacity = String(eventAttendees) + "/" + String(eventMaxParticipants)
                                    Text("Available " + eventCapacity)
                                        .foregroundColor(.white)
                                        .font(.system(size: 17, weight: .heavy, design: .default))
                                        .padding(.leading, 20)
                                        .padding(.top, -10)
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
                                    
                                    
                                    // manage button
                                }
                                

                                
                                
                                
                                // put a clear button on top of it to click into it
                            }
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
