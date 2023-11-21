//
//  NotificationView.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/27/23.
//

import UIKit
import SwiftUI
import Firebase

struct NotificationViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = NotificationViewController
    
    func makeUIViewController(context: Context) -> NotificationViewController {
        let vc = NotificationViewController()
        // Do some configurations here if needed.
        return vc
    }
    
    func updateUIViewController(_ uiViewController: NotificationViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @State var userAuth = UserAuthentication()
    @State var userm = UserMethods()
    @State var notifcationM = NotificationMethods()
    @State var eventm = EventMethods()
    
    var notificationIDs = [String]() // IDs of Notifs
    var notifications = [Notification]() // Notifications objects
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationIDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // the cells each show the message of the notification
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = notifications[indexPath.row].message
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Task {
            let selectedNotif = notifications[indexPath.row]
            
            await userAuth.getCurrUser()
            var currUser = userAuth.currUser

            let vc = SingleEventViewController()
            vc.userAuth = self.userAuth

            let event = await eventm.getEvent(eventID: selectedNotif.eventID)
            var ehl = EventHighLevel(id: event.id, name: event.eventName, location: event.location, sport: event.sport, maxParticipants: event.maxParticipants, eventHost: event.eventHostName, attendeeList: event.attendeeList, privateEvent: event.privateEvent, date: event.date, requestList: event.requestList, description: event.description, code: event.code, adminsList: event.adminsList, eventHostName: event.eventHostName)
            
            vc.event = ehl

            // if it's an invite notification, the user will join
            if (selectedNotif.messageType == .invite && !event.userIsAttending(userID: currUser?.id ?? "")) {
                
                // join the event
                ehl.joinEvent(id: userAuth.currUser?.id ?? "")
                
                // remove the user if they are in the request list
                if (ehl.requestList.contains(userAuth.currUser?.id ?? "")) {
                    ehl.requestList.remove(at: ehl.requestList.firstIndex(of: userAuth.currUser?.id ?? "") ?? 0)
                }
                
                let db = Firestore.firestore()
                do {
                    try await db.collection("Events").document(event.id).updateData(["attendeeList":ehl.attendeeList])
                    try await db.collection("Events").document(event.id).updateData(["requestList":ehl.requestList])
                    
                } catch {
                    print("Couldn't update the event in Firebase")
                }
                
                // joined success
                let joinedAlertController = UIAlertController(title: "Success", message: "You've successfully joined the event.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                joinedAlertController.addAction(okAction)
                navigationController?.pushViewController(vc, animated: true)
                present(joinedAlertController, animated: true, completion: nil)
            } else {
                
                if (selectedNotif.messageType == .invite && event.userIsAttending(userID: currUser?.id ?? "")) {
                    let joinedAlertController = UIAlertController(title: "Already joined", message: "You've already joined this event.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    joinedAlertController.addAction(okAction)
                    navigationController?.pushViewController(vc, animated: true)
                    present(joinedAlertController, animated: true, completion: nil)
                } else {
                    // push the SingleEventView for the notification regardless
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
            

        }
        

        
        // if it was a join Notification, show them a success message and have them join the event
        
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 50)
        return scrollView
    }()
    
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage(named: "DefaultProfile")
        logoView.tintColor = .yellow
        logoView.contentMode = .scaleAspectFit
        return logoView
    }()
    
    private var notificationsText: UITextView = {
        let text = UITextView()
        
        let attributedString = NSMutableAttributedString.init(string: "Notifications")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor(white: 1, alpha: 1), range: NSRange.init(location: 0, length: attributedString.length))
        text.attributedText = attributedString
        
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 40, weight: .bold)
        text.toggleUnderline(true)
        return text
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        Task {
            await userAuth.getCurrUser()
            let currUser = userAuth.currUser
            
            notificationIDs = currUser?.notifications ?? [] // IDs
            
            // turn all the notifcation IDs from the user into notifcation objects
            for noID in notificationIDs {
                await notifications.append(notifcationM.getNotification(notificationID: noID))
            }
            
            self.tableView.reloadData()
        }
        
        //scrollView.addSubview(logoView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.frame = view.bounds

        let size = view.width / 1.2
        
        view.addSubview(notificationsText)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.green
        view.addSubview(tableView)
        
        
        
        notificationsText.frame = CGRect(x: (view.width - size) / 2,
                                         y: 80, // was 50
                                         width: size,
                                         height: size)
       // notificationsText.textColor = UIColor(red: 0, green: 100, //blue: 0, alpha: 0)
        
        tableView.frame = CGRect(x: 0,
                                 y: 200, // was 50
                                 width: view.width,
                                 height: view.height)
        
        /*logoView.frame = CGRect(x: (view.width - size) / 2,
                                y: 100,
                                width: size,
                                height: size)*/
    }
}

#Preview {
    NotificationViewController()
}
