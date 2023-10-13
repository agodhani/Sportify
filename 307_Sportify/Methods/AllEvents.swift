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
    
    init(id: String, name: String){
        self.id = id
        self.name = name
    }
}

class AllEvents: ObservableObject {
    
    //@Published var users = [Users]()
    private var db = Firestore.firestore()
    @Published var events = [EventHighLevel]()
    
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
                    print(EventHighLevel(id: id, name: name))
                    return EventHighLevel(id: id, name: name)
                }
            }
        }
    }
