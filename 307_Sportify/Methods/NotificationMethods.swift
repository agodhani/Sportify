//
//  NotificationMethods.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 11/15/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class NotificationMethods: ObservableObject{
    @Published var notif: Notification!
    weak var delegate: NotificationsDelegate?
    
    init(){
        notif = Notification(id: "", date: Date.now, messageType: .join, message: "", notifierID: "", eventID: "")
    }
    
    func createNotification(type: Notification.message_type, id: String, event_name: String, host_name: String, event_id: String)
    async throws -> String {
        do {
            let userAuth = UserAuthentication()
            var user = userAuth.currUser
            var notification = Notification(id: UUID().uuidString, date: Date.now, messageType: type, message: "", notifierID: id, eventID: event_id)
            notification.message = notification.setMessage(name: host_name, eventName: event_name)
            let encodedNotification = try Firestore.Encoder().encode(notification)
            try await Firestore.firestore().collection("Notifications").document(notification.id).setData(encodedNotification)
            print("CHECK FIREBASE TO SEE IF NOTIFICATION WAS CREATED")
            self.delegate?.notificationsDidUpdate()
            return notification.id
            
        } catch {
            print("Notification Creation Failed")
            return ""
        }
    }
    
    func getNotification(notificationID: Notification.ID) async -> Notification {
        
        do {
            
            let notificationDocument = try await Firestore.firestore().collection("Notifications").document(notificationID).getDocument()
            let notificationData = try notificationDocument.data(as: Notification.self)
            print ("Notification retrieval successfully")
            self.delegate?.notificationsDidUpdate()
            return notificationData
            
        } catch {
            print("Couldn't load Notification \(notificationID)")
            return Notification(id: "", date: Date(), messageType: .kick, message: "", notifierID: "", eventID: "")
        }
        
    }
    
    
    
}
