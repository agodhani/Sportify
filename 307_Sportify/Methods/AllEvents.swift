//
//  AllEvents.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/13/23.
//

import Foundation
import Firebase


struct EventHighLevel: Identifiable {
    var id: String
    var name: String
    var location:String
    var sport: Int
    var maxParticipants: Int
    var eventHost: String
    var attendeeList: [String]
    var privateEvent: Bool
    var date: Date
    var requestList: [String]
    var description: String
    var code: String
    init(id: String, name: String, location: String, sport: Int, maxParticipants: Int, eventHost: String, attendeeList: [String], privateEvent: Bool, date: Date, requestList: [String], description: String, code: String){
        self.id = id
        self.name = name
        self.location = location
        self.sport = sport
        self.maxParticipants = maxParticipants
        self.eventHost = eventHost
        self.attendeeList = attendeeList
        self.privateEvent = privateEvent
        self.date = date
        self.requestList = requestList
        self.description = description
        self.code = code
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
        
        for attendeeID in requestList {
            var userData = try? await db.collection("Users").document(attendeeID).getDocument()
            do {
                var user = try userData!.data(as: User.self)
                userList.append(user)
            } catch {
                print("Error getting requstee as User!")
            }
        }
        return userList
    }
    
    func userIsAttending(userID: String) -> Bool {
        if (attendeeList.contains(userID)) {
            return true
        }
        return false
    }
    
    mutating func joinEvent(name: String){
        self.attendeeList.append(name)
    }
    
    mutating func generateRandomCode(length: Int) -> String {
        // generate random code
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let newCode = String ((0..<length).map{_ in letters.randomElement()!})
        self.code = newCode
        return newCode
    }
    
}
class getEvs {
    static let shared = getEvs()
    
    var events = [EventHighLevel]()
}


class AllEvents: ObservableObject {
    
    //@Published var users = [Users]()
    private var db = Firestore.firestore()
    weak var delegate: AllEventsDelegate?
    @Published var events = [EventHighLevel]()
    @Published var filteredEvents: [EventHighLevel] = []
    func getEvents(){
        db.collection("Events").addSnapshotListener {(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            
            self.events = documents.map{(queryDocumentSnapshot) -> EventHighLevel in
                    let data = queryDocumentSnapshot.data()
                    let name = data["eventName"] as? String ?? ""
                    let id = data["id"] as? String ?? ""
                    let location = data["location"] as? String ?? ""
                    let sport = data["sport"] as? Int ?? 16
                    let maxParticipants = data["maxParticipants"] as? Int ?? 0
                    let eventHost = data["eventHostID"] as? String ?? ""
                    let attendeeList = data["attendeeList"] as? [String] ?? [String]()
                    let privateEvent = data["privateEvent"] as? Bool ?? false
                    let tsdate = data["date"] as? Timestamp ?? Timestamp()
                    let date = tsdate.dateValue() // time stamp as date
                    let requestList = data["requestList"] as? [String] ?? [String]()
                    let description = data["description"] as? String ?? ""
                    let code = data["code"] as? String ?? ""
                print(EventHighLevel(id: id, name: name, location: location, sport: sport, maxParticipants: maxParticipants, eventHost: eventHost, attendeeList: attendeeList, privateEvent: privateEvent, date: date, requestList: requestList, description: description, code: code))
                getEvs.shared.events.append(EventHighLevel(id: id, name: name, location: location, sport: sport, maxParticipants: maxParticipants, eventHost: eventHost, attendeeList: attendeeList, privateEvent: privateEvent, date: date, requestList: requestList, description: description, code: code))
                self.delegate?.eventsDidUpdate()
                return EventHighLevel(id: id, name: name, location: location, sport: sport, maxParticipants: maxParticipants, eventHost: eventHost, attendeeList: attendeeList, privateEvent: privateEvent, date: date, requestList: requestList, description: description, code: code)
                }
            }
        }
    }
