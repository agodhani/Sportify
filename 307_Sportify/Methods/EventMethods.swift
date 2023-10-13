//
//  EventMethods.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/13/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class EventMethods: ObservableObject {
    
    
    
    func createEvent(eventName: String, sport: Int, maxParticipants: Int, description: String, location: String, privateEvent: Bool, id: String) async throws {
        do {
            let event = Event(id: UUID().uuidString, eventName: eventName, sport: sport, date: Date.now, location: location, numAttendees: 1, attendeeList: [], privateEvent: privateEvent, maxParticipants: maxParticipants, adminsList: Set<User>(), eventHostID: id, code: "monkeys", blackList: Set<User>(), requestList: [], description: description)
            let encodedEvent = try Firestore.Encoder().encode(event)
            try await Firestore.firestore().collection("Events").document(event.id).setData(encodedEvent)
            print("Go check Firebase to see if the Event was created")
            
            
        } catch {
            print("Event Creation Failed")
        }
        
    }
    
    func getEvent() {
        
    }
    
    func modifyEvent() {
        
    }
    
    func deleteEvent() {
        
    }
}
