//
//  User.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 9/29/23.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let email: String
    var password: String
    
    //?might not need this: let password: String
    /*
     other vars:
     Location
     Radius
     SportsPreferences
     PrivateAccount
     ProfilePicture
     Age
     Birthday
     FriendList
     BlockList
     EventsAttending
     EventsHosting
     */
    
    /*
     Methods
     joinEvent
     hostEvent
     removeEventAttending
     ...
     */
}
