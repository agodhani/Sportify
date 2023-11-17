//
//  UserProfileViewController.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 11/9/23.
//

import Foundation
import UIKit
import Firebase

class UserProfileViewController: UIViewController {
    var userAuth: UserAuthentication?
    var person: Person?
    var eventsm = EventMethods()
    var allEvents: [String] = []
    var allEventsAsEvents: [Event] = []
    
    // Name label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    // add friend button
    private let addFriendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Friend", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    @objc private func tappedAddFriend() {
        var user = userAuth?.currUser
        user?.addFriend(userID: person?.id ?? "Error")
        var userid = user?.id
        let db = Firestore.firestore()
        db.collection("Users").document(userid!)
            .updateData(["friendList": user?.friendList])
        print("FRIEND ADDED")
        Task {
            await userAuth?.getCurrUser()
        }
    }
    
    private let inviteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Invite", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    @objc private func tappedInviteButton() {
        var currUser = userAuth?.currUser
        let userid = currUser?.id ?? ""
        
        let db = Firestore.firestore()
        
        Task {
            allEvents = currUser?.getAllEvents() ?? [String]()
            
            for eventID in allEvents {
                await allEventsAsEvents.append(eventsm.getEvent(eventID: eventID))
            }
            
            let vc = InviteToEventViewController()
            vc.eventsAttending = allEventsAsEvents
            vc.userInvitingID = person?.id
            navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    
    override func viewDidLoad() {
        let user = userAuth?.currUser
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(nameLabel)
        if(!((user?.friendList.contains((person?.id ?? "")))!) && user?.id != person?.id) {
            view.addSubview(addFriendButton)
        }
        addFriendButton.addTarget(self, action: #selector(tappedAddFriend), for: .touchUpInside)

        nameLabel.text = "Name: " + (person?.name ?? "error name")
        
        view.addSubview(inviteButton)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        nameLabel.frame = CGRect(x: 40,
                                 y: 200,
                                 width: size,
                                 height: 20)
        addFriendButton.frame = CGRect(x: 90,
                                       y: 400,
                                       width: 225,
                                       height: 50)
        
        // TODO edit the positioning on this
        // coudn't do bc users aren't loading until we change the DB
        inviteButton.frame = CGRect(x: 0,
                                    y: 400,
                                    width: 225,
                                    height: 50)
    }
}

#Preview {
    UserProfileViewController()
}
