//
//  CreateEvent.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/13/23.
//

import SwiftUI

struct CreateEvent: View {
    @State private var eName = "";
    @State private var sport = "";
    @State private var maxParticipants = "0";
    @State private var description = "";
    @State private var location = "";
    @State private var isPrivate = false;
    @State private var eventm  = EventMethods()
    @State private var userAuth  = UserAuthentication()
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
            
            TextField("Sport", text: $sport)
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: -125))
            
            TextField("Location", text: $location)
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: -50))
            
            TextField("Number of Particpants", text: $maxParticipants)
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: 25))
                .keyboardType(.numberPad)
            
            TextField("Zipcode", text: $location)
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: 100))
            
            Toggle("Private Account", isOn: $isPrivate).foregroundColor(Color("SportGold"))
                .frame(width: 300, height: 50)
                .offset(CGSize(width: 0, height: 150))
            
            Button("Create Event") {
                Task {
                    if id != nil {
                        try await eventm.createEvent(eventName: eName, sport: 1, maxParticipants: 5, description: description, location: location, privateEvent: isPrivate, id: id ?? "nouid")
                    }
                }
            }.foregroundColor(.black)
                .fontWeight(.heavy)
                .frame(width: 225, height: 50)
                .background(Color("SportGold"))
                .cornerRadius(200)
                .offset(CGSize(width: 0, height: 225))
            
            
        }
        

    }
}

#Preview {
    CreateEvent()
}
