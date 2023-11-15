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
    
    init(){
        notif = Notification(id: "", date: Date.now, messageType: .join, message: "", notifierID: "")
    }
    
    func createNotification(type: Notification.message_type, id: String)
    async throws {
        do {
            let userAuth = UserAuthentication()
            var user = userAuth.currUser
            var mes = ""
            let notification = Notification(id: UUID().uuidString, date: Date.now, messageType: type, message: mes, notifierID: id)
            let encodedNotification = try Firestore.Encoder().encode(notification)
            try await Firestore.firestore().collection("Notifications").document(notification.id).setData(encodedNotification)
            print("CHECK FIREBASE TO SEE IF NOTIFICATION WAS CREATED")
            
        } catch {
            print("Notification Creation Failed")
        }
    }
    
}
