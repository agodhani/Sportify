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
    var ref = Database.database().reference()
    
    // Error event shows if the event is not found in the database
    var event = Event(id: "error", eventName: "error", sport: 0, date: Date.now, location: "error", numAttendees: 0, attendeeList: Array<User>(), privateEvent: false, maxParticipants: 0, adminsList: Set<User>(), eventHostID: "error", code: "error", blackList: Set<User>(), requestList: [], description: "error")
    
    let docRef = db.collection("Events").document(eventID)
    
    docRef.getDocument(as: Event.self) { result in
        
        switch result {
        case.success(let copy):
            event = copy
            
        case.failure(let error):
            print("Error retrieving eventID: \(error)")
            event = Event(id: "error2", eventName: "error2", sport: 0, date: Date.now, location: "error", numAttendees: 0, attendeeList: Array<User>(), privateEvent: false, maxParticipants: 0, adminsList: Set<User>(), eventHostID: "error", code: "error", blackList: Set<User>(), requestList: [], description: "error")
        }
    }
    
    
    
    /*ref.child("Events").child(eventID).observeSingleEvent(of: .value, with: { snapshot in

        let data = snapshot.value as? Event
        
        let id = data?.id
        let description = data?.description
        let eventHostID = data?.eventHostID
        let eventName = data?.eventName
        let location = data?.location
        let maxParticipants = data?.maxParticipants
        let numAttendees = data?.numAttendees
        let privateEvent = data?.privateEvent
        let requestList = data?.requestList
        let sport = data?.sport
        let adminsList = data?.adminsList
        let attendeeList = data?.attendeeList
        let blackList = data?.blackList
        let code = data?.code
        let date = data?.date
        event = Event(id: id!, eventName: eventName!, sport: sport!, date: date!, location: location!, numAttendees: numAttendees!, attendeeList: attendeeList!, privateEvent: privateEvent ?? false, maxParticipants: maxParticipants!, adminsList: adminsList!, eventHostID: eventHostID!, code: code!, blackList: blackList!, requestList: requestList!, description: description!)
        
    })*/
    return event
}*/
    /*db.collection("Events").addSnapshotListener {(querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
            print("no documents")
            return
        }*/
        //eventList = documents.map{(queryDocumentSnapshot) -> Event in
            /*
            for event in eventList {
                
                let data = queryDocumentSnapshot.data()
                let tempID = data["id"] as? String ?? ""
                
                if (tempID == eventID) {
                    let description = data["description"]
                    let eventHostID = data["eventHostID"]
                    let eventName = data["eventName"]
                    let id = data["id"]
                    let location = data["location"]
                    let maxParticipants = data["maxParticipants"]
                    let numAttendees = data["numAttendees"]
                    let privateEvent = data["privateEvent"]
                    let requestList = data["requestList"]
                    let sport = data["sport"]
                    let adminsList = data["adminsList"]
                    let attendeeList = data["attendeeList"]
                    let blackList = data["blackList"]
                    let code = data["code"]
                    let date = data["date"]
                    let event = Event(id: id as! String, eventName: eventName as! String, sport: sport as! Int, date: date as! Date, location: location as! String, numAttendees: numAttendees as! Int, attendeeList: attendeeList as! Array<User>, privateEvent: (privateEvent != nil), maxParticipants: maxParticipants as! Int, adminsList: adminsList as! Set<User>, eventHostID: eventHostID as! String, code: code as! String, blackList: blackList as! Set<User>, requestList: requestList as! [User], description: description as! String)
                    return event
            }*/
            



struct SingleEventView: View {
    @State var userAuth = UserAuthentication()
    // how to get the current user? TODO change this once figured out
    
    // EVENT TODO how to get from outside
    //@Binding var eventID: String
    @State var eventid: String = "005861C7-AB71-48EF-B17A-515E88AA0D4B" // delete this once figure out current user
    @State var eventm = EventMethods()
    
    let db = Firestore.firestore()
    //let event_id =
    
    
    //let testUser1 = User(userid: "1")
    //let testUser2 = User(userid: "2")
    
    //let testUser3 = User(userid: "3")
    //let testUser4 = User(userid: "4")
    
    var body: some View {
        var event = Event(id: "error id", eventName: "error name", sport: 0, date: Date.now, location: "error location", numAttendees: 0, attendeeList: Array<User>(), privateEvent: false, maxParticipants: 0, adminsList: Set<User>(), eventHostID: "2", code: "code", blackList: Set<User>(), requestList: [], description: "error description")
        //onAppear(perform: event = await eventm.getEvent(eventID: eventid))
        
        //var event = Event(id: "", eventName: "", sport: 0, date: Date.now, location: "", numAttendees: 0, attendeeList: Array<User>(), privateEvent: false, maxParticipants: 0, adminsList: Set<User>(), eventHostID: "", code: "", blackList: Set<User>(), requestList: [], description: "")
            //@State var currentUser = userAuth.currUser // uncomment
            @State var currentUser = User(id: "2", name: "test current user", email: "current@gmail.com", radius: 0, zipCode: "47906", sportsPreferences: [], privateAccount: false, profilePicture: "ERROR", age: 0, birthday: Date(), friendList: [], blockList: [], eventsAttending: [], eventsHosting: [])
            
            var eventName = event.eventName
            var eventDate = event.date.formatted()
            // split into day (0) and time (1)
        var eventArr = eventDate.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
            @State var dateStr = String(eventArr[0])
        @State var timeStr = String(eventArr[1])
        @State var eventLocation = event.location
        @State var eventCode = event.code
        @State var codeShowing = false
        @State var showingImage = "eye.slash"
        @State var hiddenOpacity = 1.0
        @State var revealOpacity = 0.0
        @State var typingCode = eventCode
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
                            .onAppear { // TODO this doesn't work for some reason
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
                            }
                        
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
                            
                            Group {
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
                            .padding(.leading, -130)
                            
                            
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
                            .onAppear { // TODO this doesn't work for some reason
                                Task (priority: .userInitiated) {
                                    let eventx = await eventm.getEvent(eventID: eventid)
                                    print("Test: \(eventx.eventName)")
                                    eventName = eventx.eventName
                                    eventDate = eventx.date.formatted()
                                    // split into day (0) and time (1)
                                    eventArr = eventDate.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
                                    dateStr = String(eventArr[0])
                                    timeStr = String(eventArr[1])
                                    eventLocation = eventx.location
                                    eventCode = event.code
                                }
                            }
                        
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
    SingleEventView(eventid: UUID().uuidString)
}
