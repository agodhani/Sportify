//
//  Event.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 9/30/23.
//

import Foundation
import CoreLocation

struct Event: Identifiable {
    let id: String
    var eventName: String
    var sportsList = ["Tennis", "Table Tennis", "Volleyball", "Soccer", "Basketball", "Football", "Baseball", "Badminton", "Golf", "Cycling", "Running", "Hockey", "Spikeball", "Handball", "Lacrosse", "Squash"]
    var sport: Int
    var date: Date
    var location: CLLocationCoordinate2D
    var numAttendees: Int
    var attendeeList: Set<User>
    var privateEvent: Bool
    var maxParticipants: Int
    var adminsList: Set<User>
    var eventHostID: String // this will be the user ID
    private var code: String
    var blackList: Set<User>
    var requestList: Set<User>
    
    init(hostID: String) { // created for test
        self.eventName = "test name"
        self.id = "12345"
        self.sport = 0
        self.date = Date()
        self.location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        self.numAttendees = 0
        self.attendeeList = [User(userid: "0")]
        self.privateEvent = true
        self.maxParticipants = 2
        self.adminsList = Set<User>()
        self.eventHostID = hostID
        self.code = "123"
        self.blackList = Set<User>()
        self.requestList = Set<User>()
    }
    /*
    init() { // THIS WAS CREATED AS A TEST FOR EVENT CREATION - Josh - can delete and replace later
        self.eventName = "test name"
        self.id = "12345"
        self.sport = 0
        self.date = Date()
        self.location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        self.numAttendees = 0
        self.attendeeList = [User(id: "12345", name: "test user name", email: "user@test.com", radius: 1, zipCode: "47906", sportsPreferences: Set<String>(), privateAccount: true, profilePicture: String(), age: 20, birthday: Date(), friendList: Set<String>(), blockList: Set<String>(), eventsAttending: Set<String>(), eventsHosting: Set<String>())]
        self.privateEvent = true
        self.maxParticipants = 2
        self.adminsList = Set<User>()
        self.eventHostID = "11111"
        self.code = "123"
        self.blackList = Set<User>()
        self.requestList = Set<User>()
    }*/
    

    
    mutating func kickAttendee(attendee: User) {
        self.attendeeList.remove(attendee)
        self.blackList.insert(attendee)
    }
    
    mutating func setSport(sport: Int) {
        self.sport = sport
    }
    
    mutating func setDate(date: Date) {
        self.date = date
    }
    
    mutating func setLocation(location: CLLocationCoordinate2D) {
        self.location = location
    }
    
    mutating func setNumAttendees(num: Int) {
        self.numAttendees = num
    }
    
    mutating func addAttendee(attendee: User) {
        self.attendeeList.insert(attendee)
    }
    
    mutating func setMaxParticipants(num: Int) {
        self.maxParticipants = num
    }
    
    mutating func setAdminList() {
        
    }
    
    mutating func addAdmin(admin: User) {
        self.adminsList.insert(admin)
    }
    
    mutating func setHost(host: User) {
        self.eventHostID = host.id
    }
    
    func deleteEvent() { // TODO
        
    }
    
    func getDate() -> Date {
        return self.date
    }
    
    func getLocation() -> CLLocationCoordinate2D {
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
}
