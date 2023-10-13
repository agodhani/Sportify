//
//  UserMethods.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/13/23.
//

import Foundation
import Firebase

class UserMethods: ObservableObject {
    
    func getUser(user_id: User.ID) async -> User {
        do {
            let userDocument = try await Firestore.firestore().collection("Users").document(user_id).getDocument()
            let userData = try userDocument.data(as: User.self)
            print("User loaded successfully")
            return userData
        } catch {
            print("Couldn't load user")
            return User(id: "", name: "", email: "", radius: 0, zipCode: "", sportsPreferences: Set<Int>(), privateAccount: false, profilePicture: "", age: 0, birthday: Date.now, friendList: Array<String>(), blockList: Array<String>(), eventsAttending: Set<String>(), eventsHosting: Set<String>())
        }
    }
}
