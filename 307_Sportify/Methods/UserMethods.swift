//
//  UserMethods.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/13/23.
//

import Foundation
import Firebase

class UserMethods: ObservableObject {
    weak var delegate: UserMethodsDelegate?

    
    func messageListAsUsers(messageList: [String]) async -> [User] {
        var userList = [User]()
        let db = Firestore.firestore()
        
        for userID in messageList {
            var userData = try? await db.collection("Users").document(userID).getDocument()
            do {
                var user = try userData!.data(as: User.self)
                userList.append(user)
            } catch {
                print("Error getting attendee as User!")
            }
        }
        self.delegate?.usersDidUpdate()
        return userList
    }
    
    func getUser(user_id: User.ID) async -> User {
        do {
            let userDocument = try await Firestore.firestore().collection("Users").document(user_id).getDocument()
            let userData = try userDocument.data(as: User.self)
            print("User loaded successfully")
            return userData
        } catch {
            print("Couldn't load user")
            return User(id: "", name: "", email: "", radius: 0, zipCode: "", sportsPreferences: Set<Int>(), privateAccount: false, profilePicture: "", age: 0, birthday: Date.now, friendList: Array<String>(), blockList: Array<String>(), eventsAttending: [String](), eventsHosting: [String](), suggestions: [String](), notifications: [String](), messageList: [String]())
        }
    }
}
