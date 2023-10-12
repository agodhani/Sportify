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
    @State var currentUser = User(userid: "54321") // for test 54321 = host - any other number = viewer

    // EVENT TODO how to get from outside
    @State var event: Event = Event(hostID: "54321") // delete this once figure out current user
    
    let testUser1 = User(userid: "1")
    let testUser2 = User(userid: "2")
    
    let testUser3 = User(userid: "3")
    let testUser4 = User(userid: "4")

    // TODO for all text fields - EDIT
    
    var body: some View {
        
        @State var privStr: String = "Private Event"
        @State var buttonColor: Color = .red
        
        @State var eventName = event.eventName
        @State var eventDate = event.date.formatted()
        // split into day (0) and time (1)
        let eventArr = eventDate.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
        @State var dateStr = String(eventArr[0])
        @State var timeStr = String(eventArr[1])
        //@State var dateStr = String(eventArr[0] + " at" + eventArr[1]) // TODO, this needs to be a date not string
        
        @State var eventLocation = "1234 Temp Location, Lafayette, IN 94507"
        //event.location // TODO ???
                
        let guestList: [User] = [testUser1, testUser2] // TODO set this to the actual guestList / attendee list from current event
        let testList: [User] = [testUser3, testUser4]
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack (alignment: .trailing) {
                
                // HOST VIEW
                if event.userIsEventHost(user: currentUser) {
                    
                    Button(privStr) { // TODO can't set the text and color
                        event.setPrivate(priv: !event.getPrivateEvent())
                        if (event.getPrivateEvent()) {
                            privStr = "Private Event"
                            buttonColor = .red
                        } else {
                            privStr = "Public Event"
                            buttonColor = .green
                        }
                    }
                    .foregroundColor(buttonColor)
                    .font(.system(size: 12, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    
                    
                    TextField(eventName, text: $eventName)
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .heavy, design: .default))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, -15)
                    
                    HStack {
                        TextField(dateStr, text: $dateStr)
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
                        
                        TextField(timeStr, text: $timeStr)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .heavy, design: .default))
                            .multilineTextAlignment(.leading)
                            //.frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, -40)
                    }
                    

                    
                    // Address / location
                    // TODO
                    TextField(eventLocation, text: $eventLocation)
                    .foregroundColor(.gray)
                    .font(.system(size: 15, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 391, height: 2)
                        .padding(1)
                    
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
                                                    // TODO - KICK USER
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
                            ForEach(testList, id: \.id) { guest in
                                
                                HStack (alignment: .firstTextBaseline) {
                                    let name = guest.name
                                    Text(name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .heavy, design: .default))
                                        .padding(.leading, 20)
                                    
                                    Spacer()
                                    VStack (alignment: .trailing) {
                                        HStack {
                                             // BUTTON HERE if current user is host
                                            Button("Accept") {
                                                action: do {
                                                    // TODO - ACCEPT USER
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
                    } // end ScrollView
                    
            }  else {
                // NON HOST VIEW
                
                Text(privStr)
                    .foregroundColor(.red)
                    .font(.system(size: 12, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                
                Text(eventName)
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
    } // end View
}

#Preview {
        SingleEventView()
}
