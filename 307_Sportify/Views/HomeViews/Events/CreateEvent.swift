//
//  CreateEvent.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/13/23.
//

import SwiftUI

struct CreateEvent: View {
    @State private var eName = "";
    @State private var sport = 0;
    @State private var maxParticipants = 0;
    @State private var description = "";
    @State private var location = "";
    @State private var isPrivate = false;
    @State private var eventm  = EventMethods()
    @State private var userAuth  = UserAuthentication()
    @State private var sportList = Sport.sportData()
    @State private var eventView = false;
    //@State private var date = Date.FormatString
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            let user = userAuth.currUser
            let id = user?.id
            Text("New Event")
                .foregroundColor(Color("SportGold"))
                .background(.black)
                .offset(CGSize(width: 0, height: -350))
                .font(.system(size: 40, weight: .heavy, design: .default))
            TextField("Event Name", text: $eName)
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: -275))
            
            TextField("Description", text: $description)
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: -200))
            /*
            TextField("Sport", text: $sport)
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: -125))
             */
            Text("Sport :")
                .foregroundColor(Color("SportGold"))
                .background(.black)
                .offset(CGSize(width: -77, height: -125))
                .font(.system(size: 20, weight: .regular, design: .default))
            
            Picker(selection: $sport, label: Text("Sport")) {
                ForEach(sportList.indices) { index in
                    Text(sportList[index].name)
                }
            }.offset(CGSize(width: 0.0, height: -125.0))
            
            TextField("Location", text: $location)
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: -50))
            
            
            Text("Participants :")
                .foregroundColor(Color("SportGold"))
                .background(.black)
                .offset(CGSize(width: -100, height: 25))
                .font(.system(size: 20, weight: .regular, design: .default))
            
            Picker(selection: $maxParticipants, label: Text("Participants")) {
                ForEach(1...25, id: \.self) { number in
                        Text("\(number)")
                }

                }.offset(CGSize(width: 0.0, height: 25.0))
        
            /*
            TextField("Number of Particpants", text: $maxParticipants)
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: 25))
                .keyboardType(.numberPad)
            */
            
            Toggle("Private Event", isOn: $isPrivate).foregroundColor(Color("SportGold"))
                .frame(width: 300, height: 50)
                .offset(CGSize(width: 0, height: 150))
            Button("Create Event") {
                Task {
                    if id != nil {
                        //TODO add boolean return value
                        try await eventm.createEvent(eventName: eName, sport: sport, maxParticipants: maxParticipants, description: description, location: location, privateEvent: isPrivate, id: id ?? "nouid")
                        eventView = true;
                    }
                }
            }.foregroundColor(.black)
                .fontWeight(.heavy)
                .frame(width: 225, height: 50)
                .background(Color("SportGold"))
                .cornerRadius(200)
                .offset(CGSize(width: 0, height: 225))
            
            if(eventView){
                EventsView()
            }
        }
        

    }
}

#Preview {
    CreateEvent()
}
