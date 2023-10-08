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
        do {
            let userLogin = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = userLogin.user
            await getCurrUser()
            print("sign in success")
        } catch {
            print("sign in failed")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws -> Bool {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, name: fullname, email: email, radius: 1, sportsPreferences: Set<String>(), provateAccount: true, profilePicture: Data.init(), age: 20, birthday: Date(), friendList: Set<String>(), blockList: Set<String>(), eventsAttending: Set<String>(), eventsHosting: Set<String>())
            //encode takes the "codable" protocal (in User), and encodes it as raw Data but as the User struct
            let encodedUser  = try Firestore.Encoder().encode(user)
            //adds to the collecton of Users, and adds the User data
            try await Firestore.firestore().collection("Users").document(user.id).setData(encodedUser)
            await getCurrUser()
            print("User Created")
            return true
        } catch {
            print("User Creation Failed")
            return false
        }
        
    }
    
    func getCurrUser() async {
        guard let userId = Auth.auth().currentUser?.uid else {return }
        
        guard let userInfo = try? await Firestore.firestore().collection("Users").document(userId).getDocument() else {return}
        self.currUser = try? userInfo.data(as: User.self)
        
        print("Current User is \(self.currUser)")
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currUser = nil
            print("User Signed Out")
        } catch {
            print("Sign Out Failed")
        }
    }
    
    enum EmailError: Error {
        case invalidEmail
        case otherError
    }
    
    func forgotPasswordEmail(email: String) async throws {
        
        do {
            
            try await Auth.auth().sendPasswordReset(withEmail: email)
            print("Sending forgot password email was successful")
            
        } catch {
            print("Sending forgot password email was unsuccessful")
            throw EmailError.invalidEmail
        }
        

                
    }
}
