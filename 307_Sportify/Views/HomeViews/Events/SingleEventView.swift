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
    
    // this should show if the event didn't load properly
    @State var event = Event(id: "error id", eventName: "error name", sport: 0, date: Date.now, location: "error location", numAttendees: 0, attendeeList: Array<String>(), privateEvent: false, maxParticipants: 0, adminsList: Set<User>(), eventHostID: "2", code: "code", blackList: Set<User>(), requestList: [], description: "error description")
    
    @State var userAuth = UserAuthentication()
    @State var userM = UserMethods()
    @State var allUsers = AllUsers()

    @State var eventName = ""
    @State var eventid: String // parameter - REAL - uncomment
    //@State var eventid: String = "005861C7-AB71-48EF-B17A-515E88AA0D4B" // REAL - comment out
    @State var eventm = EventMethods()
    @State var eventCode = ""
    @State var eventDate: Date = Date()
    @State var eventDateString: String = ""
    @State var eventArr: [String.SubSequence] = []
    //eventDate.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
    @State var dateStr: String = ""
    @State var timeStr: String = ""
    @State var eventLocation: String = ""
    @State var codeShowing = false
    @FocusState var isFocused: Bool
    @State var showingImage = "eye.slash"
    @State var secureOpacity = 1.0
    @State var revealOpacity = 0.0
    @State var newDate: Date = Date()
    @State var eventDescription: String = ""
    @State var maxParticipants: Int = 0
    @State var errorMessage = "Event detail cannot be left empty!"
    @State var errorOpacity = 0.0
    
    @State var deletePrompt = false;
    @State var eventsView = false;
    @State var attendeeListAsUsers = [User]()
    @State var requestListAsUsers = [User]()

    let db = Firestore.firestore()
    
    var body: some View {
                
        //let currentUser = userAuth.currUser // REAL - uncomment
        @State var currentUser = User(id: "tWqBAVZ9uFgyusKjyIFZGuyNZqb2", name: "test current user", email: "current@gmail.com", radius: 0, zipCode: "47906", sportsPreferences: [], privateAccount: false, profilePicture: "ERROR", age: 0, birthday: Date(), friendList: [], blockList: [], eventsAttending: [], eventsHosting: []) // REAL - comment
        

            ZStack {
                Color.black.ignoresSafeArea()
                
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.system(size: 15, weight: .heavy, design: .default))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.leading, 20)
                    .opacity(errorOpacity)
                    .offset(CGSize(width: 0.0, height: -315))
                
                if event.userIsEventHost(user: currentUser) { // REAL - unwrap
                    Button("Delete\nEvent") {
                        deletePrompt = true;
                    }
                    .controlSize(.mini)
                    .foregroundColor(.black)
                    .font(.system(size: 10, weight: .heavy, design: .default))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(width: 60, height: 30)
                    .background(.red)
                    .cornerRadius(200)
                    .offset(CGSize(width: 120, height: -375))
                } else { // not the event host - will be a join / leave button
                    
                    if (event.userIsAttending(userID: currentUser.id)) { // user is attending - show leave button
                        
                        Button("Leave") {
                            // TODO
                        }
                        .controlSize(.mini)
                        .foregroundColor(Color("SportsGold"))
                        .font(.system(size: 10, weight: .heavy, design: .default))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .frame(width: 60, height: 30)
                        .background(.red)
                        .cornerRadius(200)
                        .offset(CGSize(width: 120, height: -375))
                        
                    } else { // user is not attending - show join button
                        Button("Join") {
                            // TODO
                        }
                        .controlSize(.mini)
                        .foregroundColor(Color("SportsGold"))
                        .font(.system(size: 10, weight: .heavy, design: .default))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .frame(width: 60, height: 30)
                        .background(.red)
                        .cornerRadius(200)
                        .offset(CGSize(width: 120, height: -375))
                    }
                    
                    
                }

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
                        
                        
                        TextField("Event Name", text: $eventName)
                            .foregroundColor(.white)
                            .font(.system(size: 40, weight: .heavy, design: .default))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading, 20)
                            .padding(.top, -15)
                            .onSubmit {
                                if (eventName == "") {
                                    errorOpacity = 1.0
                                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                                        errorOpacity = 0.0;
                                    }
                                } else {
                                    event.eventName = event.setEventName(newName: eventName)
                                }
                            }
                        
                        // new date - using Date Picker for the host
                        DatePicker("New Date", selection: $eventDate)
                            .foregroundColor(.white)
                            .colorInvert()
                            .padding(.trailing, 165)
                            .padding(.vertical, -50)
                            .onChange(of: eventDate) {
                                event.setDate(date: eventDate)
                            }

                        
                        // Address / location
                        TextField(eventLocation, text: $eventLocation) // need to be able to update this
                            .foregroundColor(.gray)
                            .font(.system(size: 15, weight: .heavy, design: .default))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                            .onSubmit {
                                if (eventLocation == "") {
                                    errorOpacity = 1.0
                                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                                        errorOpacity = 0.0;
                                    }
                                } else {
                                    eventLocation = event.setLocation(location: eventLocation)
                                }
                            }
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 391, height: 2)
                            .padding(1)
                        
                        TextField(eventDescription, text: $eventDescription)
                            .foregroundColor(.gray)
                            .font(.system(size: 15, weight: .heavy, design: .default))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                            .padding(.vertical, 10)
                            .onSubmit {
                                if (eventDescription == "") {
                                    errorOpacity = 1.0
                                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                                        errorOpacity = 0.0;
                                    }
                                } else {
                                    eventDescription = event.setDescription(newDescription: eventDescription)
                                }
                            }
                        
                        HStack {
                            Text("Capacity: \(event.getNumAttendees()) /")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .heavy, design: .default))
                                .multilineTextAlignment(.leading)
                                .frame(alignment: .leading)
                                .padding(.bottom, 10)
                                .padding(.leading, 20)
                            
                            Picker("Max Capacity", selection: $maxParticipants) {
                                ForEach(1...100, id: \.self) { number in
                                    Text("\(number)")
                                }
                            }
                            .onChange(of: maxParticipants) {
                                maxParticipants = event.setMaxParticipants(num: maxParticipants)
                            }
                            .foregroundColor(.white)
                            .padding(.leading, -15)
                            .padding(.bottom, 10)
                            
                            
                            Spacer()
                        }

                        
                        HStack {
                            Button ("Random\nCode") {
                                event.code = event.generateRandomCode(length: 10)
                                eventCode = event.code
                            }
                            .controlSize(.mini)
                            .foregroundColor(.black)
                            .font(.system(size: 12, weight: .heavy, design: .default))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(width: 70, height: 30)
                            .background(Color("SportGold"))
                            .cornerRadius(200)
                            .padding(.leading, 20)

                            
                            Button {
                                codeShowing = !codeShowing
                                if codeShowing {
                                    showingImage = "eye"
                                    revealOpacity = 1.0
                                    secureOpacity = 0.0
                                } else {
                                    showingImage = "eye.slash"
                                    revealOpacity = 0.0
                                    secureOpacity = 1.0
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
                            
                            ZStack {
                                TextField("Code", text: $eventCode)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .heavy, design: .default))
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .textInputAutocapitalization(.never)
                                    .focused($isFocused)
                                    .onSubmit {
                                        if (eventCode == "") {
                                            errorOpacity = 1.0
                                            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                                                errorOpacity = 0.0;
                                            }
                                        } else {
                                            event.updateCode(code: eventCode)
                                        }
                                    }
                                    .opacity(revealOpacity)

                                
                                SecureField("Code", text: $eventCode)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .heavy, design: .default))
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .textInputAutocapitalization(.never)
                                    .focused($isFocused)
                                    .onSubmit {
                                        if (eventCode == "") {
                                            errorOpacity = 1.0
                                            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                                                errorOpacity = 0.0;
                                            }
                                        } else {
                                            event.updateCode(code: eventCode)
                                        }                                    }
                                    .opacity(secureOpacity)
                            }
                            .padding(.leading, -80)
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
                                
                                ForEach(attendeeListAsUsers, id: \.id) { guest in
                                                                        
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
                                                    event.removeUser(removeUser: guest)
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
                                
                                ForEach(requestListAsUsers, id: \.id) { guest in
                                    
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
                                                    event.acceptUser(acceptUser: guest.id)
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
                                                    event.rejectUser(rejectUser: guest.id)
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
                            .padding(.vertical, 10)
                            
                        
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
                                
                                ForEach(attendeeListAsUsers, id: \.id) { guest in
                                    
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
                
                if deletePrompt {
                    
                     Rectangle()
                        .fill(Color.gray)
                        .frame(width: 350, height: 150)
                        .cornerRadius(50)
                        .offset(CGSize(width: 0, height: -100))
                    
                    Text("Are you sure you want to delete \n\(eventName)?")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .offset(CGSize(width: 0, height: -125))

                    
                    Button("Yes") {
                        event.deleteEvent()
                        deletePrompt = false;
                        
                        // navigate back to the EventsView
                        eventsView = true;
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                    .multilineTextAlignment(.center)
                    .frame(width: 60, height: 30)
                    .background(.red)
                    .cornerRadius(200)
                    .offset(CGSize(width: -50, height: -75))

                    
                    Button("No") {
                        deletePrompt = false;
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                    .multilineTextAlignment(.center)
                    .frame(width: 60, height: 30)
                    .background(.green)
                    .cornerRadius(200)
                    .offset(CGSize(width: 50, height: -75))
                }
                if (eventsView) {
                    EventsView()
                }
            }
            .onAppear {
                Task (priority: .userInitiated) {
                    event = await eventm.getEvent(eventID: eventid)
                    eventName = event.eventName
                    eventDateString = event.date.formatted()
                    // split into day (0) and time (1)
                    eventArr = eventDateString.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
                    dateStr = String(eventArr[0])
                    timeStr = String(eventArr[1])
                    eventLocation = event.location
                    eventCode = event.code
                    eventDate = event.date
                    eventDescription = event.description
                    maxParticipants = event.maxParticipants
                    attendeeListAsUsers = await event.attendeeListAsUsers()
                    requestListAsUsers = await event.requestListAsUsers()
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
    SingleEventView(eventid: "005861C7-AB71-48EF-B17A-515E88AA0D4B") // UUID().uuidString
    // "005861C7-AB71-48EF-B17A-515E88AA0D4B"
}
