//
//  Event.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 9/30/23.
//

import Foundation
import CoreLocation
import Firebase
import SwiftUI

struct Event: Identifiable, Codable, Hashable {
    var id: String
    var eventName: String
    let sportsList = ["Tennis", "Table Tennis", "Volleyball", "Soccer", "Basketball", "Football", "Baseball", "Badminton", "Golf", "Cycling", "Running", "Hockey", "Spikeball", "Handball", "Lacrosse", "Squash"]
    var sport: Int
    var date: Date
    var location: String
    var numAttendees: Int
    var attendeeList: [String]
    var privateEvent: Bool
    var maxParticipants: Int
    var adminsList: [String]
    var eventHostID: String // this will be the user ID
    var code: String
    var blackList: Set<User>
    var requestList: [String]
    var description: String
   
    /*
    init(hostID: String) { // created for test
        self.eventName = "test name"
        self.id = "12345"
        self.sport = 0
        self.date = Date()
        self.location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        self.numAttendees = 0
        self.attendeeList = []
        self.privateEvent = true
        self.maxParticipants = 2
        self.adminsList = Set<User>()
        self.eventHostID = hostID
        self.code = "123"
        self.blackList = Set<User>()
        self.requestList = []
        self.description = "This is an awesome event! You should join😎"
    }
     */
    
    /*mutating func kickAttendee(attendee: User) {
        self.attendeeList.remove(attendee)
        self.blackList.insert(attendee)
    }*/
    
    mutating func generateRandomCode(length: Int) -> String { // returns a random generated 10 character alphanumeric code
        
        // generate random code
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let newCode = String ((0..<length).map{_ in letters.randomElement()!})
        self.code = newCode
        
        // update database
        self.updateCode(code: newCode)
        return newCode
    }
    
    // sets the new name, adjusts DB, and also returns the new name
    mutating func setEventName(newName: String) -> String {
        self.eventName = newName
        
        // update DB
        let db = Firestore.firestore()
        db.collection("Events").document(self.id).updateData(["eventName": newName])
        print("Event name updated: \(eventName)")
        return self.eventName
    }
    
    mutating func setDescription(newDescription: String) -> String {
        self.description = newDescription
        
        // update DB
        let db = Firestore.firestore()
        db.collection("Events").document(self.id).updateData(["description": newDescription])
        print("Event description updated: \(self.description)")
        return self.description
    }
    
    mutating func setDate(date: Date) {
        self.date = date
        
        // update DB
        let db = Firestore.firestore()
        db.collection("Events").document(self.id).updateData(["date": date])
        print("Date updated for \(self.eventName): \(self.date)")
    }
        
    mutating func setSport(sport: Int) {
        self.sport = sport
    }
    
    mutating func setPrivate(priv: Bool) {
        self.privateEvent = priv
        
        let db = Firestore.firestore()
        db.collection("Events").document(self.id).updateData(["privateEvent": priv])
        if (priv) {
            print("Event is now private")
        } else {
            print("Event is now public")
        }
    }
    
    mutating func setLocation(location: String) -> String {
        self.location = location
        
        // update DB
        let db = Firestore.firestore()
        db.collection("Events").document(self.id).updateData(["location": self.location])
        print("Location updated for \(self.eventName): \(self.location)")
        return self.location
    }
    
    mutating func setMaxParticipants(num: Int) -> Int {
        self.maxParticipants = num
        
        // update DB
        let db = Firestore.firestore()
        db.collection("Events").document(self.id).updateData(["maxParticipants": self.maxParticipants])
        print("Max Participants updated for \(self.eventName): \(self.maxParticipants)")
        return self.maxParticipants
    }
    
    mutating func kickAttendee(userID: String) async {
        let db = Firestore.firestore()
        
        if attendeeList.contains(userID) {
            do {
                attendeeList.remove(at: attendeeList.firstIndex(of: userID)!)
                try await db.collection("Events").document(self.id).updateData(["attendeeList": self.attendeeList])
                print("Attendee list updated for \(self.attendeeList): \(self.attendeeList)")
                
                let userM = UserMethods()
                var user = await userM.getUser(user_id: userID)
                // TODO here - finish this - josh
                // user.leave event
                //db.collection("Users").document(userID).updateData(["eventsAttending" : ])
                
            } catch {
                
            }

            
        } else {
            print("The given user id: \(userID) is not in the attendee list")
        }
        
    }
        
    mutating func setNumAttendees(num: Int) {
        self.numAttendees = num
    }
    
    mutating func addAttendee(attendeeID: String) {
        self.attendeeList.append(attendeeID)
    }
    
    
    mutating func setAdminList() {
        
    }
    
    mutating func setAttendeeList(newAttendeeList: [String]) {
        self.attendeeList = newAttendeeList
    }
    
    mutating func addAdmin(admin: String) {
        self.adminsList.append(admin)
    }
    
    mutating func setHost(host: User) {
        self.eventHostID = host.id
    }
    
    mutating func setRequestList(newList: [String]) {
        self.requestList = newList
    }
    
    mutating func removeUser(removeUser: User) {
        var found = false;
        for i in 1...attendeeList.endIndex {
            if attendeeList[i] == removeUser.id {
                let db = Firestore.firestore()
                attendeeList.remove(at: i)
                found = true;
                db.collection("Events").document(self.id).updateData(["attendeeList": attendeeList])
                print("User was removed")
            }
        }
        
        if !found {
            print("User not found")
        }
    }
    
    mutating func acceptUser(acceptUser: String) {
        if (requestList.contains(acceptUser)) {
            let index = attendeeList.firstIndex(of: acceptUser)!
            let db = Firestore.firestore()
            requestList.remove(at: index)
            attendeeList.append(acceptUser)
            db.collection("Events").document(self.id).updateData(["attendeeList": attendeeList])
        } else {
            print("User could not be added to attendee list")
        }
    }
    
    mutating func rejectUser(rejectUser: String) {
        if (requestList.contains(rejectUser)) {
            let index = attendeeList.firstIndex(of: rejectUser)!
            let db = Firestore.firestore()
            requestList.remove(at: index)
            db.collection("Events").document(self.id).updateData(["requestList": requestList])

        } else {
            print("User could not be removed from request list")
        }
    }
    
    mutating func updateCode(code: String) {
        self.code = code
        let db = Firestore.firestore()
        db.collection("Events").document(self.id).updateData(["code": self.code])
        print("\(eventName) code updated: \(code)")
    }
    
    func getDescription() -> String {
        return self.description
    }
    
    func deleteEvent() {
        let db = Firestore.firestore()
        db.collection("Events").document(self.id).delete() { err in
            if let err = err {
                print("Error removing: \(self.eventName) with ID \(self.id)")
            } else {
                print("Event successfully removed")
            }
        }
    }
    
    func getDate() -> Date {
        return self.date
    }
    
    func getLocation() -> String {
        return self.location
    }
    
    func getNumAttendees() -> Int{
        return numAttendees
    }
    
    func getPrivateEvent() -> Bool {
        return privateEvent
    }
    
    func userIsEventHost(user: User) -> Bool {
        if (self.eventHostID == user.id) {
            return true
        }
        return false
    }
    
    func acceptUser() {
        
    }
    
    func getPrivStr() -> String {
        if (getPrivateEvent()) {
            return "Private Event"
        } else {
            return "Public Event"
        }
    }
    
    func getPrivColor() -> Color {
        if (getPrivateEvent()) {
            return .red
        } else {
            return .green
        }
    }
    
    func userIsAttending(userID: String) -> Bool {
        if (attendeeList.contains(userID)) {
            return true
        }
        return false
    }
    
    func attendeeListAsUsers() async -> [User] {
        var userList = [User]()
        let db = Firestore.firestore()
        
        for attendeeID in attendeeList {
            var userData = try? await db.collection("Users").document(attendeeID).getDocument()
            do {
                var user = try userData!.data(as: User.self)
                userList.append(user)
            } catch {
                print("Error getting attendee as User!")
            }
        }
        return userList
    }
    
    func requestListAsUsers() async -> [User] {
        var userList = [User]()
        let db = Firestore.firestore()
        
        for requestID in requestList {
            var userData = try? await db.collection("Users").document(requestID).getDocument()
            do {
                var user = try userData!.data(as: User.self)
                userList.append(user)
            } catch {
                print("Error getting attendee as User!")
            }
        }
        return userList
    }
    
}
