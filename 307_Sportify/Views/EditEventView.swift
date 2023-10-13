//
//  EditEventView.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/12/23.
//

import SwiftUI

struct EditEventView: View {
    @State var userAuth = UserAuthentication()
    @State var event: Event = Event(hostID: "54321")
    @State var newDate: Date = Date()
    @State var newLocation: String = ""
    @State var newNumPeople: Int = 0
    
    var body: some View {
        @State var eventName = event.eventName
        @State var eventDate = event.date.formatted()
        let eventArr = eventDate.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
        @State var dateStr = String(eventArr[0])
        @State var timeStr = String(eventArr[1])
        @State var eventLocation = "1234 Temp Location, Lafayette, IN 94507"
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .trailing) {
                Button(event.getPrivStr()) {
                    
                    action: do {
                        Task {
                            event.setPrivate(priv: !event.getPrivateEvent())
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
                
                DatePicker("Please select a date", selection: $newDate)
                    .foregroundColor(.white)
                
                
                TextField("New Location", text: $newLocation)
                
                TextField("New Number of People", value: $newNumPeople, formatter: NumberFormatter())
            }
        }
    }
}

#Preview {
    EditEventView()
}
