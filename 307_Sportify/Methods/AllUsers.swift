//
//  AllUsers.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 10/13/23.
//

import Foundation
import Firebase


struct Person: Identifiable {
    var id: String
    var name: String
    var zipCode: String
    var sportPreferences: [Int]
    
    init(id: String, name: String, zipCode: String, sportPreferences: [Int]){
        self.id = id
        self.name = name
        self.zipCode =  zipCode
        self.sportPreferences = sportPreferences
    }
}

class AllUsers: ObservableObject {
    
    //@Published var users = [Users]()
    private var db = Firestore.firestore()
    @Published var users = [Person]()
    @Published var filteredUsers: [Person] = []
    weak var delegate: AllUsersDelegate?

    
    func getUsers(){
        db.collection("Users").addSnapshotListener {(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            
            self.users = documents.map{(queryDocumentSnapshot) -> Person in
                    let data = queryDocumentSnapshot.data()
                    let name = data["name"] as? String ?? ""
                    let id = data["id"] as? String ?? ""
                    let zipCode = data["zipCode"] as? String ?? ""
                    let sportPreferences = data["sportsPreferences"] as? [Int] ?? []
                print(Person(id: id, name: name, zipCode: zipCode, sportPreferences: sportPreferences))
                self.delegate?.usersDidUpdate()
                return Person(id: id, name: name, zipCode: zipCode, sportPreferences: sportPreferences)
                }
            }
        }
    }
