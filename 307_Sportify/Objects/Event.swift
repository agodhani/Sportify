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
    var sprtsList = ["Tennis", "Table Tennis", "Volleyball", "Soccer", "Basketball", "Football", "Baseball", "Badminton", "Golf", "Cycling", "Running", "Hockey", "Spikeball", "Handball", "Lacrosse", "Squash"]
    var sport: Int
    var date: Date
    var location: CLLocationCoordinate2D
    var numAttendees: Int
    var attendeeList: Set<User>
    var pbvateEvent: Bool
    var maxParticipants: Int
    var adminsList: Set<User>
    var eventHost: User
    private var code: String
    var blackList: Set<User>
    
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
        self.eventHost = host
    }
    
    func deleteEvent() {
        
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
}
