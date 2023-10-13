//
//  SingleEventView.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/10/23.
//

import SwiftUI

struct SingleEventView: View {
    @State var userAuth = UserAuthentication()
    // how to get the current user? TODO change this once figured out
    
    // EVENT TODO how to get from outside
    @State var event: Event = Event(hostID: "54321") // delete this once figure out current user
    // @EnvironmentObject var event: Event
    @State private var goToEditEvent = false
    
   // let testUser1 = User(from: "1" as! Decoder)
    //let testUser2 = User(userid: "2")
    
    //let testUser3 = User(userid: "3")
    //let testUser4 = User(userid: "4")
    
    var body: some View {
        @State var currentUser = userAuth.currUser
        @State var eventName = event.eventName
        @State var eventDate = event.date.formatted()
        // split into day (0) and time (1)
        let eventArr = eventDate.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
        @State var dateStr = String(eventArr[0])
        @State var timeStr = String(eventArr[1])
        //@State var dateStr = String(eventArr[0] + " at" + eventArr[1]) // TODO, this needs to be a date not string
        
        @State var eventLocation = "1234 Temp Location, Lafayette, IN 94507"
        //event.location // TODO ???
       /*
        let guestList: [User] = [testUser1, testUser2] // TODO set this to the actual guestList / attendee list from current event
        let testList: [User] = [testUser3, testUser4] // TODO this
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack (alignment: .trailing) {
                
                // HOST VIEW
                if event.userIsEventHost(user: currentUser) {
                    
                    // change Private/Public event by clicking on it top left
                    Button(event.getPrivStr()) {
                        
                        action: do {
                            Task {
                                event.setPrivate(priv: !event.getPrivateEvent()) // this works
                            }
                        }
                    }
                    .foregroundColor(event.getPrivColor())
                    .font(.system(size: 12, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    
                    
                    TextField(event.eventName, text: $event.eventName)
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .heavy, design: .default))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, -15)
                    
                    HStack {
                        TextField(dateStr, text: $dateStr) // TODO need to be able to update this
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .heavy, design: .default))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                        
                        Text("at")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .heavy, design: .default))
                            //.frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, -55)
                        
                        TextField(timeStr, text: $timeStr) // need to be able to update this
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .heavy, design: .default))
                            .multilineTextAlignment(.leading)
                            //.frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, -40)
                    }
                    

                    
                    // Address / location
                    // TODO
                    TextField(eventLocation, text: $eventLocation) // need to be able to update this
                    .foregroundColor(.gray)
                    .font(.system(size: 15, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 391, height: 2)
                        .padding(1)
                    
                    TextField(event.getDescription(), text: $event.description)
                        .foregroundColor(.gray)
                        .font(.system(size: 15, weight: .heavy, design: .default))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                    
                    // Guest List
                    Text("Guest List")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .heavy, design: .default))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 30)
                    ScrollView {
                        VStack (alignment: .leading) {
                            
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 391, height: 2)
                                .padding(1)
                            
                            // TODO make sure this is the actual guestList once figure out real currentEvent / user
                            ForEach(guestList, id: \.id) { guest in
                                
                                HStack (alignment: .firstTextBaseline) {
                                    let name = guest.name
                                    Text(name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .heavy, design: .default))
                                        .padding(.leading, 20)
                                    
                                    Spacer()
                                    VStack (alignment: .trailing) {
                                        // BUTTON HERE if current user is host
                                        if event.userIsEventHost(user: currentUser) {
                                            Button("Remove") {
                                                action: do {
                                                    // TODO - REMOVE USER
                                                    event.removeUser(removeUser: guest) // idk if this updates the UI properly in real life
                                                }
                                            }
                                            .foregroundColor(.black)
                                            .fontWeight(.heavy)
                                                .frame(width: 75, height: 30)
                                                .background(Color("SportGold"))
                                                .cornerRadius(200)
                                                .font(.system(size: 13, weight: .heavy, design: .default))
                                                .padding(.trailing, 20)
                                        }
                                    }
                                }
                                .padding(7)
                                
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 391, height: 2)
                                    .padding(1)
                            }
                            
                        } // end VStack
                    } // end ScrollView
                    
                    Text("Request List")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .heavy, design: .default))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 30)
                    
                    ScrollView {
                        VStack (alignment: .leading) {
                            
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 391, height: 2)
                                .padding(1)
                            
                            // TODO make sure this is the actual guestList once figure out real currentEvent / user
                            ForEach(event.requestList, id: \.id) { guest in
                                
                                HStack (alignment: .firstTextBaseline) {
                                    let name = guest.name
                                    Text(name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .heavy, design: .default))
                                        .padding(.leading, 20)
                                    
                                    Spacer()
                                    VStack (alignment: .trailing) {
                                        HStack {
                                            Button("Accept") {
                                                action: do {
                                                    // TODO - ACCEPT USER
                                                    event.acceptUser(acceptUser: guest)
                                                }
                                            }
                                            .foregroundColor(.black)
                                            .fontWeight(.heavy)
                                                .frame(width: 75, height: 30)
                                                .background(Color(.green))
                                                .cornerRadius(200)
                                                .font(.system(size: 13, weight: .heavy, design: .default))
                                            
                                            Button("Reject") {
                                                action: do {
                                                    // TODO - REJECT USER
                                                    event.rejectUser(rejectUser: guest) // needs to be tested
                                                }
                                            }
                                            .foregroundColor(.black)
                                            .fontWeight(.heavy)
                                                .frame(width: 75, height: 30)
                                                .background(Color(.red))
                                                .cornerRadius(200)
                                                .font(.system(size: 13, weight: .heavy, design: .default))
                                                .padding(.trailing, 20)
                                        }
                                    }
                                }
                                .padding(7)
                                
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 391, height: 2)
                                    .padding(1)
                            } // end ForEach
                        }
                        Spacer()
                        Button("Edit Event") {
                            goToEditEvent = true
                        }
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                            .frame(width: 200, height: 50)
                            .background(Color("SportGold"))
                            .cornerRadius(200)
                            .font(.system(size: 15, weight: .heavy, design: .default))
                            .padding()
                        
                    } // end ScrollView
                    
            }  else {
                // NON HOST VIEW
                
                Text(event.getPrivStr())
                    .foregroundColor(event.getPrivColor())
                    .font(.system(size: 12, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                
                Text(event.eventName)
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, -15)
                
                    Text(String(dateStr + " at " + timeStr))
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .heavy, design: .default))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                
                // Address / location
                // TODO
                Text(eventLocation)
                .foregroundColor(.gray)
                .font(.system(size: 15, weight: .heavy, design: .default))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 391, height: 2)
                    .padding(1)
                
                Text(event.getDescription())
                    .foregroundColor(.gray)
                    .font(.system(size: 15, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                
                // Guest List
                Text("Guest List")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 30)
                ScrollView {
                    VStack (alignment: .leading) {
                        
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 391, height: 2)
                            .padding(1)
                        
                        // TODO make sure this is the actual guestList once figure out real currentEvent / user
                        ForEach(guestList, id: \.id) { guest in
                            
                            HStack (alignment: .firstTextBaseline) {
                                let name = guest.name
                                Text(name)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .heavy, design: .default))
                                    .padding(.leading, 20)
                            }
                            .padding(7)
                            
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 391, height: 2)
                                .padding(1)
                        }
                    } // end VStack
                } // end ScrollView
                
            } // end else

                
            } // end VStack
        } // end ZStack
        
        .onAppear(perform: {
            event.setRequestList(newList: testList) // delete this once real event works
        })
        
        if (goToEditEvent) {
            NavigationView {
                EditEventView()
            }
        }
        */
    } // end View
}

#Preview {
        SingleEventView()
}
