//
//  Notification.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 11/15/23.
//

import Foundation
import CoreLocation
import Firebase
import SwiftUI

struct Notification: Identifiable, Codable, Hashable {
    var id: String
    var date: Date
    enum message_type: String, Codable {
        case kick, join, leave, promote
    }
    var messageType: message_type
    var message: String
    var notifierID: String
    
    
    
    mutating func setMessage(){
        switch(messageType) {
            case .kick:
                self.message = "YOU HAVE BEEN KICKED"
            case .join:
                self.message = "YOU HAVE JOINED AN EVENT"
            case .leave:
                self.message = "YOU HAVE LEFT AN EVENT"
            case .promote:
                self.message = "You have been promoted"
        }
    }
    
    func getMessage() -> String {
        return self.message
    }
    
    mutating func setNotifier(notifier: User) {
        notifierID = notifier.id
    }
    
    
}
