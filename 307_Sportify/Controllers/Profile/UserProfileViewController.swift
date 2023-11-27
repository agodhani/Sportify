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
    
    // add friend button
    private let blockUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("Block User", for: .normal)
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
    
    @objc private func tappedBlockUser() {
        var user = userAuth?.currUser
        let userid = user?.id
        if(user?.blockList.contains(person?.id ?? "") ?? false) {
            let index = user?.blockList.firstIndex(of: person?.id ?? "") ?? 0
            user?.blockList.remove(at: index)
            blockUserButton.setTitle("Block User", for: .normal)
        } else {
            user?.blockList.append(person?.id ?? "")
            blockUserButton.setTitle("Unblock User", for: .normal)

        }
        let db = Firestore.firestore()
        db.collection("Users").document(userid!)
            .updateData(["blockList": user?.blockList])
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
    
    override func viewDidLoad() {
        let user = userAuth?.currUser
        super.viewDidLoad()
        view.backgroundColor = .black
        if(user?.blockList.contains(person?.id ?? "") ?? false) {
            blockUserButton.setTitle("Unblock User", for: .normal)
        } else {
            blockUserButton.setTitle("Block User", for: .normal)

        }
        view.addSubview(blockUserButton)
        view.addSubview(nameLabel)
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        if(!((user?.friendList.contains((person?.id ?? "")))!) && user?.id != person?.id) {
            view.addSubview(addFriendButton)
        }
        addFriendButton.addTarget(self, action: #selector(tappedAddFriend), for: .touchUpInside)
        blockUserButton.addTarget(self, action: #selector(tappedBlockUser), for: .touchUpInside)

        nameLabel.text = "Name: " + (person?.name ?? "error name")
        
        view.addSubview(inviteButton)
        inviteButton.addTarget(self, action: #selector(tappedInviteButton), for: .touchUpInside)
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
        
        inviteButton.frame = CGRect(x: 90,
                                    y: addFriendButton.bottom + 40,
                                    width: 225,
                                    height: 50)
        blockUserButton.frame = CGRect(x: 90,
                                    y: inviteButton.bottom + 40,
                                    width: 225,
                                    height: 50)
        backButton.frame = CGRect(x: 10, y: 60, width: 70, height: 30)
    }
}

#Preview {
    UserProfileViewController()
}
