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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsAttending?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = eventsAttending?[indexPath.row].eventName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent = eventsAttending?[indexPath.row]
        
        if (!(selectedEvent?.userIsAttending(userID: userInvitingID ?? "") ?? false) ) {
            // if the user isn't attending the event, invite the user to the event
            
            // TODO ANDREW send user notification they were invited
            // the notification will let them join no matter what
            // when clicked, even if the event is private
            
            // TODO JOSH
            // If they're in the requestList, be sure to remove them from requestList
            // to keep the DB clean
            
            // TODO JOSH show a success alert message
        } else {
            // TODO JOSH show user is already attending event message
        }
        
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
}
