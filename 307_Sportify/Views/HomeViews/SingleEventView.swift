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
    @State var currentUser = User(userid: "54321")

    // EVENT TODO how to get from outside
    let event: Event = Event(hostID: "54321") // delete this once figure out current user
    
    let testUser1 = User(userid: "1")
    let testUser2 = User(userid: "2")
    
    let testUser3 = User(userid: "3")
    let testUser4 = User(userid: "4")

    // TODO for all text fields - EDIT
    
    var body: some View {
                
        let guestList: [User] = [testUser1, testUser2] // TODO set this to the actual guestList / attendee list from current event
        let testList: [User] = [testUser3, testUser4]
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack (alignment: .trailing) {
                
                // private / public
                if event.getPrivateEvent() {
                    Text("Private Event")
                        .foregroundColor(.red)
                        .font(.system(size: 12, weight: .heavy, design: .default))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                } else {
                    Text("Public Event")
                        .foregroundColor(.green)
                        .font(.system(size: 12, weight: .heavy, design: .default))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                }
                
                
                // Event Name
                let eventName = event.eventName
                Text(eventName)
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, -15)
                
                // Event Date
                let eventDate = event.date.formatted()
                // split into day (0) and time (1)
                let eventArr = eventDate.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
                let dateStr = String(eventArr[0] + " at" + eventArr[1])
                Text(dateStr)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                
                // Address / location
                // TODO
                let eventLocation = event.location // zip code ? TODO
                Text("1234 Temp Location, Lafayette, IN 94507")
                .foregroundColor(.gray)
                .font(.system(size: 15, weight: .heavy, design: .default))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 391, height: 2)
                    .padding(1)
                
                
                // Join / leave button
                
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
                        
                    }
                }
                
                if event.userIsEventHost(user: currentUser) {
                    
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
                                
                            }
                            
                        }
                    }
                    
                }
                
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 391, height: 2)
                    .padding(1)
                
                
                
               Spacer()
            }
            
        }
        
    }
}

#Preview {
        SingleEventView()
}
