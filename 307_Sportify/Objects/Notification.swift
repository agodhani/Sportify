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
        case kick, join, leave, promote, joinedMyEvent
    }
    var messageType: message_type
    var message: String
    var notifierID: String
    
    
    
    func setMessage(name: String, eventName: String) -> String {
        var message = ""
        switch(messageType) {
            case .kick:
                message = "You were kicked from \(eventName) by \(name) on \(self.date)"
            case .join:
                message = "You joined \(eventName) on \(self.date)"
            case .leave:
                message = "You left \(eventName) on \(self.date)"
            case .promote:
                message = "You were promoted to Admin by \(name) for \(eventName) on \(self.date)"
            case .joinedMyEvent:
                message = "\(name) joined your event: \(eventName) on \(self.date)"
        }
        return message
    }
    
    func getMessage() -> String {
        return self.message
    }
    
    mutating func setNotifier(notifier: User) {
        notifierID = notifier.id
    }
    
    
}
