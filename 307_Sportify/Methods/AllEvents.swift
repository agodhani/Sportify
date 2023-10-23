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
    init(id: String, name: String, location: String, sport: Int, maxParticipants: Int, eventHost: String){
        self.id = id
        self.name = name
        self.location = location
        self.sport = sport
        self.maxParticipants = maxParticipants
        self.eventHost = eventHost
    }
}

class AllEvents: ObservableObject {
    
    //@Published var users = [Users]()
    private var db = Firestore.firestore()
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
                print(EventHighLevel(id: id, name: name, location: location, sport: sport, maxParticipants: maxParticipants, eventHost: eventHost))
                return EventHighLevel(id: id, name: name, location: location, sport: sport, maxParticipants: maxParticipants, eventHost: eventHost)
                }
            }
        }
    }
