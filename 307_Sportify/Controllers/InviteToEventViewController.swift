//
//  InviteToEventViewController.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 11/16/23.
//

import Foundation
import UIKit
import Firebase
class InviteToEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userAuth = UserAuthentication()
    var eventsAttending: [Event]?
    var userInvitingID: String?
    var userm = UserMethods()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsAttending?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = eventsAttending?[indexPath.row].eventName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedEvent = eventsAttending?[indexPath.row]
        
        if (!(selectedEvent?.userIsAttending(userID: userInvitingID ?? "") ?? false) ) {
            // if the user isn't attending the event, invite the user to the event
            
            // TODO ANDREW send user notification they were invited
            // the notification will let them join no matter what
            // when clicked, even if the event is private
            
            Task {
                
                await userAuth.getCurrUser()
                let currUser = userAuth.currUser
                let currUserID = currUser?.id
                
                let notifsm = NotificationMethods()
                
                // create invite notification
                let notificationID = try await notifsm.createNotification(type: .invite, id: currUserID ?? "", event_name: selectedEvent?.eventName ?? "", host_name: selectedEvent?.eventHostName ?? "", event_id: selectedEvent?.id ?? "")
                
                // append notification to user
                var invitingUser = await userm.getUser(user_id: userInvitingID ?? "")
                invitingUser.notifications.insert(notificationID, at:0)
                
                // change DB
                let db = Firestore.firestore()
                try await db.collection("Users").document(userInvitingID ?? "").updateData(["notifications":invitingUser.notifications])
                
                
                // show a success alert message that the user was invited
                var invitedAlertController = UIAlertController(title: "Invite success!", message: "Successfully invited to the event.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                invitedAlertController.addAction(okAction)
                self.present(invitedAlertController, animated: true, completion: nil)
            }
        } else {
            
            // show a message if the user is already attending the event
            var alertController = UIAlertController(title: "Invite fail", message: "This user is already attending this event.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var inviteText: UITextView = {
        let text = UITextView()
        
        let attributedString = NSMutableAttributedString.init(string: "INVITE")
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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(inviteText)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = view.width / 1.2
        view.frame = view.bounds
        tableView.reloadData()
        backButton.frame = CGRect(x: 10, y: 60, width: 70, height: 30)
        inviteText.frame = CGRect(x: (view.width - size) / 2,
                                  y: 80, // was 50
                                  width: size,
                                  height: size)
        
        tableView.frame = CGRect(x: 0,
                                 y: 200, // was 50
                                 width: view.width,
                                 height: view.height)
    }
    // Back button
    private let backButton: UIButton = {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
               backButton.setTitle("Back", for: .normal)
               backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
               backButton.sizeToFit()
        return backButton
    }()
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        //        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        //backButton.frame = CGRect(x: 10, y: 60, width: 70, height: 30)

    }
}

#Preview {
    InviteToEventViewController()
}
