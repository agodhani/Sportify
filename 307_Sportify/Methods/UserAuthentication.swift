//
//  UserAuthentication.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 9/30/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import MessageUI

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
    
    func signIn(withEmail email: String, password: String) async throws -> Bool {
        do {
            let userLogin = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = userLogin.user
            await getCurrUser()
            print("sign in success")
            return true
            
        } catch {
            print("sign in failed")
            return false
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String, privateAccount: Bool, zipCode: String, sport: Int) async throws -> Bool {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, name: fullname, email: email, radius: 1, zipCode: zipCode, sportsPreferences: [sport], privateAccount: privateAccount, profilePicture: String(), age: 20, birthday: Date(), friendList: [String](), blockList: [String](), eventsAttending: [String](), eventsHosting: [String](), suggestions: [String](), notifications: [String](), messageList: [String](), generalNotifications: true, dmNotifications: true, eventNotifications: true, friendRequestNotifications: true)
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
            do {
            let userInfo = try? await Firestore.firestore().collection("Users").document(userId).getDocument()
            if let user = try userInfo?.data(as: User.self) {
                self.currUser = user
                print("Current User is \(self.currUser ?? User(id: "", name: "", email: "", radius: 0, zipCode: "", sportsPreferences: [], privateAccount: false, profilePicture: "", age: 0, birthday: Date.now, friendList: [], blockList: [], eventsAttending: [], eventsHosting: [], suggestions: [], notifications: [], messageList: [], generalNotifications: false, dmNotifications: false, eventNotifications: false, friendRequestNotifications: false))")
            }
        } catch {
          print("User fetching data failed")
        }
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
    
    func forgotPasswordEmail(email: String) async throws -> Bool {
        
        do {
            
            try await Auth.auth().sendPasswordReset(withEmail: email)
            print("Sending forgot password email was successful")
            return true
            
        } catch {
            print("Sending forgot password email was unsuccessful")
            return false
            throw EmailError.invalidEmail
        }
        return false
        
    }
}
