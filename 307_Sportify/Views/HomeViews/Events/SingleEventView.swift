//
//  SingleEventView.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/10/23.
//
import Foundation
import SwiftUI
import Firebase
/*
func getEvent(eventID: String) -> Event {
    var db = Firestore.firestore()
    
    var eventList = [Event]()

    db.collection("Events").addSnapshotListener {(querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
            print("no documents")
        }
        eventList = documents.map{(queryDocumentSnapshot) -> Event in
            let data = queryDocumentSnapshot.data()
            let tempID = data["id"] as? String ?? ""
            
            if (tempID == eventID) {
                return data as Event
            }
        }
    }
}*/

struct SingleEventView: View {
    @State var userAuth = UserAuthentication()
    // how to get the current user? TODO change this once figured out
    
    // EVENT TODO how to get from outside
    //@Binding var eventID: String
    @State var eventid: String // delete this once figure out current user
    @State var eventm = EventMethods()
    //@State var event =
    
    //let testUser1 = User(userid: "1")
    //let testUser2 = User(userid: "2")
    
    //let testUser3 = User(userid: "3")
    //let testUser4 = User(userid: "4")
    
    var body: some View {
        var event: Event
        Task {
            event = try await eventm.getEvent(eventID: self.eventid)
        }
        if(event ) {
            
        }
        //@State var currentUser = userAuth.currUser // uncomment
        @State var currentUser = User(id: "2", name: "test current user", email: "current@gmail.com", radius: 0, zipCode: "47906", sportsPreferences: [], privateAccount: false, profilePicture: "ERROR", age: 0, birthday: Date(), friendList: [], blockList: [], eventsAttending: [], eventsHosting: [])
        
        @State var eventName = event.eventName
        @State var eventDate = event.date.formatted()
        // split into day (0) and time (1)
        let eventArr = eventDate.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
        @State var dateStr = String(eventArr[0])
        @State var timeStr = String(eventArr[1])
        @State var eventLocation = event.location
        
        //@State var dateStr = String(eventArr[0] + " at" + eventArr[1]) // TODO, this needs to be a date not string
        
        //event.location // TODO ???
                
        //let guestList: [User] = [testUser1, testUser2] // TODO set this to the actual guestList / attendee list from current event
        //let testList: [User] = [testUser3, testUser4] // TODO this
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack (alignment: .trailing) {
                
                // HOST VIEW
                if event.userIsEventHost(user: currentUser) { // unwrap
                    
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
                    
                    
                    Text(event.eventName)
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
                    
                    Text(event.description)
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
                            ForEach(event.attendeeList, id: \.id) { guest in
                                
                                HStack (alignment: .firstTextBaseline) {
                                    let name = guest.name
                                    Text(name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .heavy, design: .default))
                                        .padding(.leading, 20)
                                    
                                    Spacer()
                                    VStack (alignment: .trailing) {
                                        // BUTTON HERE if current user is host
                                        if event.userIsEventHost(user: currentUser) { // unwrap
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
                        ForEach(event.attendeeList, id: \.id) { guest in
                            
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
            event.setRequestList(newList: event.requestList) // delete this once real event works
        })
         
    } // end View
}

#Preview {
    SingleEventView(eventid: UUID().uuidString)
}
