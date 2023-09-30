//
//  UserAuthentication.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 9/30/23.
//

import Foundation
import Firebase

class UserAuthentication: ObservableObject {
    //? means could be null or declare some value
    @Published var userSession: FirebaseAuth.User?
    @Published var currUser: User?
    
    func signIn(withEmail email: String, password: String) async throws {
        print("Sign in")
    }
    
    func createUser(with email: String, password: String, fullname: String) async throws {
        print("User Created")
    }
    
    func forgotPassword() {
        
    }
}
