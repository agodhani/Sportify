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
        thisEvent = Event(id: "", eventName: "", sport: 0, date: Date.now, location: "", numAttendees: 0, attendeeList: Array<String>(), privateEvent: false, maxParticipants: 0, adminsList: Array<String>(), eventHostID: "", eventHostName: "", code: "", blackList: Set<User>(), requestList: [String](), description: "")
    }
    init(eventID: String) async {
        thisEvent = await getEvent(eventID: eventID)
    }
    
    func createEvent(eventName: String, sport: Int, maxParticipants: Int, description: String, location: String, privateEvent: Bool, id: String) async throws {
        do {
            let userAuth = UserAuthentication()
            var user = userAuth.currUser
            let event = Event(id: UUID().uuidString, eventName: eventName, sport: sport, date: Date.now, location: location, numAttendees: 1, attendeeList: Array<String>(), privateEvent: privateEvent, maxParticipants: maxParticipants, adminsList: Array<String>(), eventHostID: id, eventHostName: user?.name ?? "Error Getting name", code: "monkeys", blackList: Set<User>(), requestList: [], description: description)
            
            user?.eventsHosting.append(event.id)
            //need to call modify user to insert here
            let encodedEvent = try Firestore.Encoder().encode(event)
            try await Firestore.firestore().collection("Events").document(event.id).setData(encodedEvent)
            print("Go check Firebase to see if the Event was created")
            
            
        } catch {
            print("Event Creation Failed")
        }
    }
    
    // Added return value to store event picture
    func createEvent(eventName: String, sport: Int, maxParticipants: Int, description: String, location: String, privateEvent: Bool, id: String, code: String, date: Date) async throws -> String {
        do {
            let userAuth = UserAuthentication()
            await userAuth.getCurrUser()
            var user = userAuth.currUser
            let event = Event(id: UUID().uuidString, eventName: eventName, sport: sport, date: date, location: location, numAttendees: 1, attendeeList: [id], privateEvent: privateEvent, maxParticipants: maxParticipants, adminsList: Array<String>(), eventHostID: id, eventHostName: user?.name ?? "Error getting name", code: code, blackList: Set<User>(), requestList: [], description: description)
            
            //user?.eventsHosting.append(event.id)
            //
            user!.hostEvent(eventID: event.id)
            
            //need to call modify user to insert here
            let encodedEvent = try Firestore.Encoder().encode(event)
            try await Firestore.firestore().collection("Events").document(event.id).setData(encodedEvent)
            print("Go check Firebase to see if the Event was created")
            
            return event.id
            
        } catch {
            print("Event Creation Failed")
        }
        return ""
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
            return Event(id: "", eventName: "", sport: 0, date: Date.now, location: "", numAttendees: 0, attendeeList: Array<String>(), privateEvent: false, maxParticipants: 0, adminsList: Array<String>(), eventHostID: "", eventHostName: "", code: "", blackList: Set<User>(), requestList: [], description: "")
        }
    }
    
    func getAllEvents() async {
        var eventArr: [Event]
        
        do {
            let eventDocuments = Firestore.firestore().collection("Events").getDocuments() {(querySnapshot, err) in
                if let err = err {
                    print("Error getting event documents: \(err)")
                } else {
                    for event in querySnapshot!.documents {
                        // TODO
                    }
                }
            }
            
        } catch {
            print("Event Data retrival failed")
        }
    }
    
    func modifyEvent(eventID: Event.ID, eventName: String, date: Date, location: String, attendeeList: Array<String>, privateEvent: Bool, maxParticipants: Int, adminsList: Set<User>, eventHostID: String, code: String, blackList: Set<User>, requestList: [String], description: String, sport: Int) async throws -> Bool {
        
        do {
            let event = try await self.getEvent(eventID: eventID)
            if(eventName != event.eventName) {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["eventName": eventName])
            }
            if sport != event.sport {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["sport": sport])
            }
            if(date != event.date) {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["date": date])
            }
            if(location != event.location) {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["location": location])
            }
            if(attendeeList != Array<String>()) {
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
            if(eventHostID != event.eventHostID) {
                try await Firestore.firestore().collection("eventHostID").document(event.id).updateData(["eventHostID": eventHostID])
            }
            if(code != event.code) {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["code": code])
            }
            if(blackList != Set<User>()) {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["blackList": blackList])
            }
            if(requestList != []) {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["requestList": requestList])
            }
            if(description != event.description) {
                try await Firestore.firestore().collection("Events").document(event.id).updateData(["description": description])
            }
            return true
            
            //"eventName": event.eventName, "date": event.date, "location": event.location, "attendeeList": event.attendeeList, "privateEvent":event.privateEvent, "maxParticipants":event.maxParticipants, "adminsList":event.adminsList, "eventHostID" : event.eventHostID, "code":event.code, "blackList": event.blackList, "requestList": event.requestList, "description":event.description
        } catch {
            print("your stuff is broken - cannot update event")
            return false
        }
        
    }
    
    func generateRandomCode(length: Int) -> String {
        // generate random code
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let newCode = String ((0..<length).map{_ in letters.randomElement()!})
        return newCode
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
