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
     
    func joinEvent(eventID: String, user: User) {
        let eventm = EventMethods()
        Task {
            var event = try await eventm.getEvent(eventID: eventID)
            let attendeeList = event.attendeeList //.append(user)
            try await eventm.modifyEvent(eventID: eventID, eventName: "", date: event.date, location: "", attendeeList: [String](), privateEvent: event.privateEvent, maxParticipants: 0, adminsList: Set<User>(), eventHostID: "", code: "", blackList: Set<User>(), requestList: [String](), description: "")
        }
    }
    
    func leaveEvent() {
        
    }
    
    func hostEvent() {
        
    }
    
    mutating func addFriend(name: String) {
        friendList.append(name)
    }
    
    mutating func removeEventAttending(eventID: String) { // TODO update db
        if eventsAttending.contains(eventID) {
            eventsAttending.remove(at: eventsAttending.firstIndex(of: eventID)!)
        }
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
        var allEvents = eventsAttending
        allEvents.append(contentsOf: eventsHosting)
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
