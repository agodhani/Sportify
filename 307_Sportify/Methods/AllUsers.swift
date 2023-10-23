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
    
    init(id: String, name: String, zipCode: String){
        self.id = id
        self.name = name
        self.zipCode =  zipCode
    }
}

class AllUsers: ObservableObject {
    
    //@Published var users = [Users]()
    private var db = Firestore.firestore()
    @Published var users = [Person]()
    
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
                print(Person(id: id, name: name, zipCode: zipCode))
                return Person(id: id, name: name, zipCode: zipCode)
                }
            }
        }
    }
