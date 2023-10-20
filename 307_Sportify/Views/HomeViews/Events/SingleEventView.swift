//
//  SingleEventView.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/10/23.
//
import Foundation
import SwiftUI
import Firebase

struct SingleEventView: View {
    
    @State var event = Event(id: "error id", eventName: "error name", sport: 0, date: Date.now, location: "error location", numAttendees: 0, attendeeList: Array<User>(), privateEvent: false, maxParticipants: 0, adminsList: Set<User>(), eventHostID: "2", code: "code", blackList: Set<User>(), requestList: [], description: "error description")
    
    @State var userAuth = UserAuthentication()

    @State var eventName = ""
    //@State var eventid: String // parameter - REAL - uncomment
    @State var eventid: String = "005861C7-AB71-48EF-B17A-515E88AA0D4B" // REAL - comment
    @State var eventm = EventMethods()
    @State var eventCode = ""
    @State var eventDate: String = ""
    @State var eventArr: [String.SubSequence] = []
    //eventDate.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
    @State var dateStr: String = ""
    @State var timeStr: String = ""
    @State var eventLocation: String = ""
    
    let db = Firestore.firestore()
    
    var body: some View {
        
        //let currentUser = userAuth.currUser // REAL - uncomment
        @State var currentUser = User(id: "tWqBAVZ9uFgyusKjyIFZGuyNZqb2", name: "test current user", email: "current@gmail.com", radius: 0, zipCode: "47906", sportsPreferences: [], privateAccount: false, profilePicture: "ERROR", age: 0, birthday: Date(), friendList: [], blockList: [], eventsAttending: [], eventsHosting: []) // REAL - comment
            
        @FocusState var isFocused: Bool
        @State var codeShowing = false
        @State var showingImage = "eye.slash"
        @State var hiddenOpacity = 1.0
        @State var revealOpacity = 0.0
        
            ZStack {
                Color.black.ignoresSafeArea()
                
                Text("Text here to run .onAppear()")
                    .hidden()

                
                VStack (alignment: .trailing) {
                        
                    
                    // HOST VIEW
                    if event.userIsEventHost(user: currentUser) { // REAL - unwrap
                        
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
                        
                        HStack { // TODO must update code in the database
                            
                            Button {
                                codeShowing = !codeShowing
                                if codeShowing {
                                    showingImage = "eye"
                                } else {
                                    showingImage = "eye.slash"
                                }
                            } label: {
                                Image(systemName: "\(showingImage)")
                            }
                            .padding(.trailing, -30)
                            .controlSize(.mini)
                            
                            Text("Code:")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .heavy, design: .default))
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                            
                            TextField("Code", text: $eventCode)
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .heavy, design: .default))
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, -120)
                                .textInputAutocapitalization(.never)
                                .focused($isFocused) // <-- add here
                            
                            Button("Save") {
                                
                            }
                            .padding(.leading, -250)

                            
                            /*Group {
                                if (!codeShowing) {
                                    SecureField("Code", text: $eventCode)
                                        .autocapitalization(.none)
                                        .opacity(1.0)
                                } else {
                                    TextField ("Code", text: $eventCode)
                                        .autocapitalization(.none)
                                        .opacity(1.0)
                                }
                            }
                            .foregroundColor(.gray)
                            .font(.system(size: 15, weight: .heavy, design: .default))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, -130)*/
                            
                            
                            /*
                            ZStack {
                                SecureField("Code", text: $typingCode)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .heavy, design: .default))
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, -130)
                                    .opacity(hiddenOpacity)
                                    .onAppear {
                                        Task {
                                            if codeShowing {
                                                hiddenOpacity = 0.0
                                            } else {
                                                hiddenOpacity = 1.0
                                            }
                                        }
                                    }
                                
                                TextField("Code", text: $typingCode)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .heavy, design: .default))
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, -130)
                                    .opacity(revealOpacity)
                                    .onAppear {
                                        Task {
                                            if codeShowing {
                                                revealOpacity = 1.0
                                            } else {
                                                revealOpacity = 0.0
                                            }
                                        }
                                    }
                                Button("Save") {
                                    event.code = typingCode
                                }
                                .padding(.leading, -180)
                                .controlSize(.mini)
                            }*/
                        }

                        
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
                                            if event.userIsEventHost(user: currentUser) { // REAL - unwrap
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
                                                    db.collection("Events").document(eventid).updateData(["attendeeList": event.attendeeList])
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
                                                    db.collection("Events").document(eventid).updateData(["attendeeList": event.attendeeList])
                                                    
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
            }
            .onAppear {
                Task (priority: .userInitiated) {
                    event = await eventm.getEvent(eventID: eventid)
                    eventName = event.eventName
                    eventDate = event.date.formatted()
                    // split into day (0) and time (1)
                    eventArr = eventDate.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
                    dateStr = String(eventArr[0])
                    timeStr = String(eventArr[1])
                    eventLocation = event.location
                    eventCode = event.code
                }
            } // end ZStack
        /*
            .onAppear(perform: {
                do {
                    event = await eventm.getEvent(eventID: eventid)
                    eventName = event.eventName
                    eventDate = event.date.formatted()
                    // split into day (0) and time (1)
                    eventArr = eventDate.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
                    dateStr = String(eventArr[0])
                    timeStr = String(eventArr[1])
                    eventLocation = event.location
                    eventCode = event.code
                }
            })*/
    } // end View
}

#Preview {
    SingleEventView(eventid: UUID().uuidString) // UUID().uuidString
    // "005861C7-AB71-48EF-B17A-515E88AA0D4B"
}
