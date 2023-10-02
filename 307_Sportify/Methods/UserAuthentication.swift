//
//  UserAuthentication.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 9/30/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserAuthentication: ObservableObject {
    //? means could be null or declare some value
    @Published var userSession: FirebaseAuth.User?
    @Published var currUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await getCurrUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        let userLogin = try await Auth.auth().signIn(withEmail: email, password: password)
        self.userSession = userLogin.user
        await getCurrUser()
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, name: fullname, email: email, radius: 1, sportsPreferences: Set<String>(), provateAccount: true, profilePicture: Data.init(), age: 20, birthday: Date(), friendList: Set<String>(), blockList: Set<String>(), eventsAttending: Set<String>(), eventsHosting: Set<String>())
            //encode takes the "codable" protocal (in User), and encodes it as raw Data but as the User struct
            let encodedUser  = try Firestore.Encoder().encode(user)
            //adds to the collecton of Users, and adds the User data
            try await Firestore.firestore().collection("Users").document(user.id).setData(encodedUser)
            print("User Created")
        } catch {
            print("User Creation Failed")
        }
        
    }
    
    func getCurrUser() async {
        guard let userId = Auth.auth().currentUser?.uid else {return }
        
        guard let userInfo = try? await Firestore.firestore().collection("Users").document(userId).getDocument() else {return}
        self.currUser = try? userInfo.data(as: User.self)
        
        print("Current User is \(self.currUser)")
    }
    
    func forgotPasswordFindEmail(email: String) async throws {
        print("Finding associated email")
        
        // TODO - JOSH
        
        // query the database for user associated with email
        
        
        // return true if email found
            // send email with code to the email
        
        // return false if email not found
        
    }
}
