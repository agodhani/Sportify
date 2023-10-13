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
    @Published var thisEvent: Event!
    
    init (){
        thisEvent = Event(id: "", eventName: "", sport: 0, date: Date.now, location: "", numAttendees: 0, attendeeList: Array<User>(), privateEvent: false, maxParticipants: 0, adminsList: Set<User>(), eventHostID: "", code: "", blackList: Set<User>(), requestList: [], description: "")
    }
    init(eventID: String) async {
        thisEvent = await getEvent(eventID: eventID)
    }
    
    func createEvent(eventName: String, sport: Int, maxParticipants: Int, description: String, location: String, privateEvent: Bool, id: String) async throws {
        do {
            let event = Event(id: UUID().uuidString, eventName: eventName, sport: sport, date: Date.now, location: location, numAttendees: 1, attendeeList: Array<User>(), privateEvent: privateEvent, maxParticipants: maxParticipants, adminsList: Set<User>(), eventHostID: id, code: "monkeys", blackList: Set<User>(), requestList: [], description: description)
            let userAuth = UserAuthentication()
            var user = userAuth.currUser
            user?.eventsHosting.insert(event.id)
            //need to call modify user to insert here
            let encodedEvent = try Firestore.Encoder().encode(event)
            try await Firestore.firestore().collection("Events").document(event.id).setData(encodedEvent)
            print("Go check Firebase to see if the Event was created")
            
            
        } catch {
            print("Event Creation Failed")
        }
        
    }
    
    func getEvent(eventID: Event.ID) async -> Event {
        do{
            let eventDocument = try await Firestore.firestore().collection("Events").document(eventID).getDocument()
            let eventData = try eventDocument.data(as: Event.self)
            print("Event Data retrival successful")
            self.thisEvent = eventData
            return eventData
        } catch {
            print("Event Data retrival failed - you suck!")
            return Event(id: "", eventName: "", sport: 0, date: Date.now, location: "", numAttendees: 0, attendeeList: Array<User>(), privateEvent: false, maxParticipants: 0, adminsList: Set<User>(), eventHostID: "", code: "", blackList: Set<User>(), requestList: [], description: "")
        }
    }
    
    func modifyEvent(eventID: Event.ID, eventName: String, date: Date, location: String, attendeeList: Array<User>, privateEvent: Bool, maxParticipants: Int, adminsList: Set<User>, eventHostID: String, code: String, blackList: Set<User>, requestList: [User], description: String) async throws {
        
        do {
            let event = try await self.getEvent(eventID: eventID)
            if(eventName != "") {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["eventName": eventName])
            }
            if(date != event.date) {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["date": date])
            }
            if(location != "") {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["location": location])
            }
            if(attendeeList != Array<User>()) {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["attendeeList": attendeeList])
            }
            if(privateEvent != event.privateEvent) {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["privateEvent": privateEvent])
            }
            if(maxParticipants != 0) {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["maxParticipants": maxParticipants])
            }
            if(adminsList != Set<User>()) {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["adminsList": adminsList])
            }
            if(eventHostID != "") {
                try await Firestore.firestore().collection("eventHostID").document(event.id).updateData(["eventHostID": date])
            }
            if(code != "") {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["code": code])
            }
            if(blackList != Set<User>()) {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["blackList": blackList])
            }
            if(requestList != []) {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["requestList": requestList])
            }
            if(description != "") {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["description": description])
            }
            
            //"eventName": event.eventName, "date": event.date, "location": event.location, "attendeeList": event.attendeeList, "privateEvent":event.privateEvent, "maxParticipants":event.maxParticipants, "adminsList":event.adminsList, "eventHostID" : event.eventHostID, "code":event.code, "blackList": event.blackList, "requestList": event.requestList, "description":event.description
        } catch {
            print("your stuff is broken - cannot update event")
        }
        
    }
    
    func deleteEvent(eventID: Event.ID) async {
        do {
            try await Firestore.firestore().collection("Events").document(eventID).delete()
            print("your event was deleted loser")
        } catch {
            print("Cannot delete event - time to play!")
        }
    }
}
