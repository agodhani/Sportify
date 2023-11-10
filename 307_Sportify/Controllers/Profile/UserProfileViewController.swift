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
        user?.addFriend(name: person?.name ?? "Error Friend")
        var userid = user?.id
        let db = Firestore.firestore()
        db.collection("Users").document(userid!)
            .updateData(["friendList": user?.friendList])
        print("FRIEND ADDED")
        Task {
            await userAuth?.getCurrUser()
        }
    }
    
    
    override func viewDidLoad() {
        let user = userAuth?.currUser
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(nameLabel)
        if(!((user?.friendList.contains((person?.name ?? "")))!) && user?.name != person?.name) {
            view.addSubview(addFriendButton)
        }
        addFriendButton.addTarget(self, action: #selector(tappedAddFriend), for: .touchUpInside)

        nameLabel.text = "Name: " + (person?.name ?? "error name")
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
    }
}
