//
//  User.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 9/29/23.
//

import Foundation
import CoreLocation
import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

// Extend CLLocation to allow encoding
extension CLLocation: Encodable {
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case altitude
        case horizontalAccuracy
        case verticalAccuracy
        case speed
        case course
        case timestamp
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
        try container.encode(altitude, forKey: .altitude)
        try container.encode(horizontalAccuracy, forKey: .horizontalAccuracy)
        try container.encode(verticalAccuracy, forKey: .verticalAccuracy)
        try container.encode(speed, forKey: .speed)
        try container.encode(course, forKey: .course)
        try container.encode(timestamp, forKey: .timestamp)
    }
}
/*
//  Wrapper to allow decoding of CLLocation
struct LocationWrapper: Decodable {
    var location: CLLocation
    
    init(location: CLLocation) {
        self.location = location
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CLLocation.CodingKeys.self)
        
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        let altitude = try container.decode(CLLocationDistance.self, forKey: .altitude)
        let horizontalAccuracy = try container.decode(CLLocationAccuracy.self, forKey: .horizontalAccuracy)
        let verticalAccuracy = try container.decode(CLLocationAccuracy.self, forKey: .verticalAccuracy)
        let speed = try container.decode(CLLocationSpeed.self, forKey: .speed)
        let course = try container.decode(CLLocationDirection.self, forKey: .course)
        let timestamp = try container.decode(Date.self, forKey: .timestamp)
        
        let location = CLLocation(coordinate: CLLocationCoordinate2DMake(latitude, longitude), altitude: altitude, horizontalAccuracy: horizontalAccuracy, verticalAccuracy: verticalAccuracy, course: course, speed: speed, timestamp: timestamp)
                
        self.init(location: location)
    }

}
*/
struct User: Identifiable, Codable, Hashable {
    let id: String
    var name: String
    var email: String
    
    //var location: CLLocation
    var radius: Int
    var zipCode: String
    var sportsPreferences: Set<Int>
    var privateAccount: Bool
    var profilePicture: String
    var age: Int
    var birthday: Date
    var friendList: [String]
    var blockList: [String]
    var eventsAttending: [String]
    var eventsHosting: [String]
    var suggestions: [String]
    var notifications: [String]
    var messageList: [String]
    
    //?might not need this: let password: String
/*
    init(id: String, name: String, email: String, password: String, location: CLLocation, radius: Int, sportsPreferences: Set<String>, provateAccount: Bool, profilePicture: Data, age: Int, birthday: Date, friendList: Set<String>, blockList: Set<String>, eventsAttending: Set<String>, eventsHosting: Set<String>) {
        self.id = id
        self.name = name
        self.email = email
        
        //self.location = location
        self.radius = radius
        self.sportsPreferences = sportsPreferences
        self.provateAccount = provateAccount
        self.profilePicture = profilePicture
        self.age = age
        self.birthday = birthday
        self.friendList = friendList
        self.blockList = blockList
        self.eventsAttending = eventsAttending
        self.eventsHosting = eventsHosting
    }
    
    // TODO
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CLLocation.CodingKeys.self)

        //var decodedLocation = try container.decode(, forKey: )
                
        self.init(id: <#T##String#>, name: <#T##String#>, email: <#T##String#>, password: <#T##String#>, location: location, radius: <#T##Int#>, sportsPreferences: <#T##Set<String>#>, provateAccount: <#T##Bool#>, profilePicture: <#T##Data#>, age: <#T##Int#>, birthday: <#T##Date#>, friendList: <#T##Set<String>#>, blockList: <#T##Set<String>#>, eventsAttending: <#T##Set<String>#>, eventsHosting: <#T##Set<String>#>)
    }
 */
     
    mutating func joinEvent(eventID: String) {
        eventsAttending.append(eventID)
        let db = Firestore.firestore()
        db.collection("Users").document(id).updateData(["eventsAttending":eventsAttending])
    }
    
    mutating func leaveEvent(eventID: String) {
        if let index = eventsAttending.firstIndex(of: eventID) {
            eventsAttending.remove(at: index)
        }
        let db = Firestore.firestore()
        db.collection("Users").document(id).updateData(["eventsAttending":eventsAttending])
        
    }
    
    mutating func hostEvent(eventID: String) {
        eventsAttending.append(eventID)
        eventsHosting.append(eventID)
        let db = Firestore.firestore()
        db.collection("Users").document(id).updateData(["eventsAttending":eventsAttending])
        db.collection("Users").document(id).updateData(["eventsHosting":eventsHosting])
    }
    
    mutating func addFriend(name: String) {
        friendList.append(name)
    }
    
    mutating func newSuggestion(suggestion: String){
        suggestions.append(suggestion)
    }
    
    mutating func removeEventAttending(eventID: String) { // TODO update db
        if eventsAttending.contains(eventID) {
            eventsAttending.remove(at: eventsAttending.firstIndex(of: eventID)!)
        }
    }
    
    /*
     * Function to update the current event host into a new event host
     * given the event ID and the new host ID.
     * Updates both users, event, and the database.
     * returns EventHighLevel
     */
    mutating func promoteNewHost(forEventID: String, newHostID: String) async -> EventHighLevel {
        
        let db = Firestore.firestore()

        // change the real event host eventsHosting
        // remove from eventsHosting
        if let index = eventsHosting.firstIndex(of: forEventID) {
            eventsHosting.remove(at: index)
            
            // update DB for current host
            do {
                try await db.collection("Users").document(id).updateData(["eventsHosting":self.eventsHosting])
            } catch {
                print("Failed to update eventsHosting for \(self.name): \(self.id)")
            }
        }
        
        // change the new event host eventsHosting
        let userm = UserMethods()
        var newHost = await userm.getUser(user_id: newHostID)
        newHost.eventsHosting.append(forEventID)
        
        // update DB for new event host
        do {
            try await db.collection("Users").document(newHostID).updateData(["eventsHosting":newHost.eventsHosting])
        } catch {
            print("Failed to update eventsHosting for \(newHost.name): \(newHost.id)")
        }
        
        // change the event
        let eventm = EventMethods()
        var event = await eventm.getEvent(eventID: forEventID)
        
        // change eventHostName and eventHostID
        event.eventHostName = newHost.name
        event.eventHostID = newHost.id
        
        // update DB for the new event
        do {
            try await db.collection("Events").document(forEventID).updateData(["eventHostName":newHost.name])
            try await db.collection("Events").document(forEventID).updateData(["eventHostID":newHostID])
        } catch {
            print("Failed to update event")
        }
        
        // return EventHighLevel so that can update UI
        return EventHighLevel(id: event.id, name: event.eventName, location: event.location, sport: event.sport, maxParticipants: event.maxParticipants, eventHost: event.eventHostName, attendeeList: event.attendeeList, privateEvent: event.privateEvent, date: event.date, requestList: event.requestList, description: event.description, code: event.code, adminsList: event.adminsList, eventHostName: event.eventHostName)
        
    }
    
    
    func sendInvite() {
        
    }
    

    func getUsername() -> String {
        return self.name
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    
    func getAge() -> Int {
        return self.age
    }
    
    func getRadius() -> Int {
        return self.radius
    }
    
    func getEventsHosting() -> [String] {
        return self.eventsHosting
    }

    func getEventsAttending() -> [String] {
        return self.eventsAttending;
    }

    func getAllEvents() -> [String] { // returns all the IDs of events part of 
        //let allEvents = self.eventsAttending.append(contentsOf: self.eventsHosting)
        let arr1 = eventsAttending
        let arr2 = eventsHosting
        
        let set1 = Set(arr1)
        let set2 = Set(arr2)
        
        let combinedSet = set1.union(set2)
        let allEvents = Array(combinedSet)
        
        return allEvents
    }
    
    func getBlockedList() -> [String] {
        return self.blockList
    }
    
    mutating func setUsername(name: String) {
        self.name = name
    }
    
    mutating func setEmail(email: String) {
        self.email = email
    }
    
    mutating func setAge(age: Int) {
        self.age = age
    }
    
    mutating func setRadius(radius: Int) {
        self.radius = radius
    }
    
    mutating func blockUser(blockUserID: String) {
        //let ref: DatabaseReference! = Database.database().reference()
        if (!blockList.contains(blockUserID)) {
            blockList.append(blockUserID)
        }
        //ref.child("Users").child(self.id).setValue(["blockList": blockList]) // update DB
    }
    
    mutating func unblockUser(unblockUserID: String) {
        //let ref: DatabaseReference! = Database.database().reference()
        
        if (blockList.contains(unblockUserID)) {
            blockList.remove(at: blockList.firstIndex(of: unblockUserID)!)
        }
        //ref.child("Users").child(self.id).setValue(["blockList": blockList]) // update DB
    }
    mutating func addNotification(message: String) {
        notifications.append(message)
    }
    
    func isBlocked(userID: String) -> Bool {
        if (blockList.contains(userID)) {
            return true
        }
        return false
        
    }
    
    //mutating func setProfilePic(picture: UIImage) {
    //    self.profilePicture = picture.pngData()!
    //}
    
    //func getProfilePic() -> UIImage {
      //  let picture: UIImage? = UIImage(data: self.profilePicture)
      //  if (picture == nil) {
      //      return nil
      //  }
        //return picture!
    //}
 
}
