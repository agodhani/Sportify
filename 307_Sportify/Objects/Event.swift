//
//  Event.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 9/30/23.
//

import Foundation
import CoreLocation
import SwiftUI

struct Event: Identifiable {
    let id: String
    var eventName: String
    var sportsList = ["Tennis", "Table Tennis", "Volleyball", "Soccer", "Basketball", "Football", "Baseball", "Badminton", "Golf", "Cycling", "Running", "Hockey", "Spikeball", "Handball", "Lacrosse", "Squash"]
    var sport: Int
    var date: Date
    var location: CLLocationCoordinate2D
    var numAttendees: Int
    var attendeeList: [User]
    var privateEvent: Bool
    var maxParticipants: Int
    var adminsList: Set<User>
    var eventHostID: String // this will be the user ID
    private var code: String
    var blackList: Set<User>
    var requestList: [User]
    var description: String
    
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
        self.requestList = [User(userid: "1")]
        self.description = "This is an awesome event! You should join😎"
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
    

    
    /*mutating func kickAttendee(attendee: User) {
        self.attendeeList.remove(attendee)
        self.blackList.insert(attendee)
    }*/
    
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
        self.attendeeList.append(attendee)
    }
    
    mutating func setMaxParticipants(num: Int) {
        self.maxParticipants = num
    }
    
    mutating func setAdminList() {
        
    }
    
    mutating func setAttendeeList(newAttendeeList: [User]) {
        self.attendeeList = newAttendeeList
    }
    
    mutating func setPrivate(priv: Bool) {
        self.privateEvent = priv
    }
    
    mutating func addAdmin(admin: User) {
        self.adminsList.insert(admin)
    }
    
    mutating func setHost(host: User) {
        self.eventHostID = host.id
    }
    
    mutating func setRequestList(newList: [User]) {
        self.requestList = newList
    }
    
    mutating func removeUser(removeUser: User) {
        var found = false;
        for i in 1...attendeeList.endIndex {
            if attendeeList[i].id == removeUser.id {
                attendeeList.remove(at: i)
                found = true;
                print("User was removed")
            }
        }
        
        if !found {
            print("User not found")
        }
    }
    
    mutating func acceptUser(acceptUser: User) {
        if (requestList.contains(acceptUser)) { // might not work, might need to copy removeUser logic^^^
            let index = attendeeList.firstIndex(of: acceptUser)!
            requestList.remove(at: index)
            attendeeList.append(acceptUser)
        } else {
            print("User could not be added to attendee list")
        }
    }
    
    mutating func rejectUser(rejectUser: User) {
        if (requestList.contains(rejectUser)) { // might not work, might need to copy removeUser logic^^^
            let index = attendeeList.firstIndex(of: rejectUser)!
            requestList.remove(at: index)
        } else {
            print("User could not be removed from request list")
        }
    }
    
    func getDescription() -> String {
        return self.description
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
    
}
