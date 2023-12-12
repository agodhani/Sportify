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
        case kick, join, leave, promote, joinedMyEvent, invite, request, newDM, announcement, newFriend
    }
    var messageType: message_type
    var message: String
    var notifierID: String
    var eventID: String
    
    
    func setMessage(name: String, eventName: String) -> String {
        var message = ""
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy hh:mm a"
        let formattedDate = format.string(from: self.date)
        switch(messageType) {
            case .kick:
                message = "You were kicked from \(eventName) by \(name) on \(formattedDate)"
            case .join:
                message = "You joined \(eventName) on \(formattedDate)"
            case .leave:
                message = "You left \(eventName) on \(formattedDate)"
            case .promote:
                message = "You were promoted by \(name) for \(eventName) on \(formattedDate)"
            case .joinedMyEvent:
                message = "\(name) joined your event: \(eventName) on \(formattedDate)"
            case .invite:
                message = "You were invited by \(name) to join \(eventName). Click to join!"
            case .request:
                message = "\(name) has requested to join \(eventName) on \(formattedDate)"
            case .newDM:
                message = "\(name) created a new chat with you on \(formattedDate)"
            case .announcement:
                message =  "You received an Announcement from \(name): \(eventName)"
            case .newFriend:
                message = "\(name) added you as a friend on \(formattedDate)"
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
