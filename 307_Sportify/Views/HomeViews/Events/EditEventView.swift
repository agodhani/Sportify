//
//  EditEventView.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/12/23.
//

import SwiftUI

struct EditEventView: View {
    @State var userAuth = UserAuthentication()
    @State var eventsm = EventMethods()
 //   @State var event: Event = Event(hostID: "54321")
    @State var newDate: Date = Date()
    @State var newLocation: String = ""
    @State var newNumPeople: Int = 0
    @State var newPrivate: Bool = false
    
    var body: some View {
        @State var eventLocation = "1234 Temp Location, Lafayette, IN 94507"
        ZStack {
            Color.black.ignoresSafeArea()
            //for testing purposes
            var eventid = "0EA0ACAD-03B0-402B-860F-DE6E7D846A32"
            
            VStack(alignment: .trailing) {
//                Toggle("Private Event", isOn: $newPrivate)
//                .foregroundColor(Color("SportGold"))
//                .font(.system(size: 12, weight: .heavy, design: .default))
//                .multilineTextAlignment(.leading)
//                .padding(.leading, 20)
//                
//                TextField("New event name", text: <#T##Binding<String>#>)
//                    .foregroundColor(.white)
//                    .font(.system(size: 40, weight: .heavy, design: .default))
//                    .multilineTextAlignment(.leading)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading, 20)
//                    .padding(.top, -15)
//                
//                HStack {
//                    TextField(dateStr, text: $dateStr) // TODO need to be able to update this
//                        .foregroundColor(.white)
//                        .font(.system(size: 20, weight: .heavy, design: .default))
//                        .multilineTextAlignment(.leading)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 20)
//                    
//                    Text("at")
//                        .foregroundColor(.white)
//                        .font(.system(size: 20, weight: .heavy, design: .default))
//                        //.frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, -55)
//                    
//                    TextField(timeStr, text: $timeStr) // need to be able to update this
//                        .foregroundColor(.white)
//                        .font(.system(size: 20, weight: .heavy, design: .default))
//                        .multilineTextAlignment(.leading)
//                        //.frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, -40)
//                }
//                
//
//                
//                // Address / location
//                // TODO
//                TextField(eventLocation, text: $eventLocation) // need to be able to update this
//                .foregroundColor(.gray)
//                .font(.system(size: 15, weight: .heavy, design: .default))
//                .multilineTextAlignment(.leading)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.leading, 20)
//                
//                Rectangle()
//                    .fill(Color.white)
//                    .frame(width: 391, height: 2)
//                    .padding(1)
//                
//                TextField(event.getDescription(), text: $event.description)
//                    .foregroundColor(.gray)
//                    .font(.system(size: 15, weight: .heavy, design: .default))
//                    .multilineTextAlignment(.leading)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading, 20)
                
                Toggle("Private Event", isOn: $newPrivate)
                    .foregroundColor(Color("SportGold"))
                
                DatePicker("New Date", selection: $newDate)
                    .foregroundColor(.white)
                    .padding()
                    .colorInvert()
                
                
                
                TextField("New Location", text: $newLocation)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                    .offset(CGSize(width: 0, height: 50))
                
                TextField("New Number of People", value: $newNumPeople, formatter: NumberFormatter())
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                    .offset(CGSize(width: 0, height: 50))
                
                Button("Update Event Details") {
                    // TODO update events in firebase
                    Task {
                        //try await eventsm.modifyEvent(eventID: eventid, eventName: "Change", date: newDate, location: newLocation, attendeeList: [], privateEvent: newPrivate, maxParticipants: 0, adminsList: Set<User>(), eventHostID: "", code: "", blackList: Set<User>(), requestList: [], description: "Changing the description")
                    }
                }
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .frame(width: 225, height: 50)
                .background(Color("SportGold"))
                .cornerRadius(200)
                .offset(CGSize(width: 0, height: 100))
            }
        }
    }
}

#Preview {
    EditEventView()
}
