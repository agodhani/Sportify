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
                
                HStack (spacing: 30) {
                    
                    Text("Event") // default font size is 17
                    
                    Text("Capacity")
                    
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
                            
                            HStack {
                                // Event
                                let eventName = event.eventName
                                Text(eventName)
                                    .foregroundColor(.white)
                                    .font(.system(size: 25, weight: .heavy, design: .default))
                                
                                
                                // Capacity
                                let eventAttendees = event.numAttendees
                                let eventMaxParticipants = event.maxParticipants
                                let eventCapacity = String(eventAttendees) + "/" + String(eventMaxParticipants)
                                Text(eventCapacity)
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .heavy, design: .default))
                                
                                // Sport
                                let eventSport = event.sport // this is an int
                                // convert int to the actual sport
                                let sportString = event.sportsList[eventSport]
                                Text(sportString)
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .heavy, design: .default))
                                
                                
                                // Location TODO - int? string?
                                let eventLocation = event.location // zip code int
                                
                                
                                // Date
                                let eventDate = event.date
                                
                                // private / public
                                
                                // manage button
                                
                                // put a clear button on top of it
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
