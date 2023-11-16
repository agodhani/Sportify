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
    
    
    
    mutating func setMessage(name: String, eventName: String){
        switch(messageType) {
            case .kick:
                self.message = "You were kicked from \(eventName) by \(name) on \(self.date)"
            case .join:
                self.message = "You joined the event: \(eventName) on \(self.date)"
            case .leave:
                self.message = "You left the event: \(eventName) on \(self.date)"
            case .promote:
                self.message = "You were promoted to Admin by \(name) for \(eventName) on \(self.date)"
            case .joinedMyEvent:
                self.message = "\(name) joined your event: \(eventName) on \(self.date)"
        }
    }
    
    func getMessage() -> String {
        return self.message
    }
    
    mutating func setNotifier(notifier: User) {
        notifierID = notifier.id
    }
    
    
}
