//
//  ProfileViewController.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/26/23.
//

import UIKit
import SwiftUI
import Firebase

struct ProfileViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ProfileViewController
    @ObservedObject var allEvents = AllEvents()
    
    func makeUIViewController(context: Context) -> ProfileViewController {
        let vc = ProfileViewController()
        // Do some configurations here if needed.
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

class ProfileViewController: UIViewController {

    @State var userAuth = UserAuthentication()
    let db = Firestore.firestore()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    // Profile picture
    private var picView: UIImageView = {
        let picView = UIImageView()
        picView.image = UIImage(systemName: "person")
        picView.layer.masksToBounds = true
        picView.contentMode = .scaleAspectFit
        //picView.layer.cornerRadius = picView.width / 10
        picView.layer.borderWidth = 2
        picView.layer.borderColor = UIColor.lightGray.cgColor
        return picView
    }()
    
    // Name label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.lightGray.cgColor
        return label
    }()
    
    // User name
    private func userName(user: User) -> UILabel {
        let label = UILabel()
        label.text = user.name
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.lightGray.cgColor
        return label
    }
    
    // Location label
    private let locLabel: UILabel = {
        let label = UILabel()
        label.text = "Location:"
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    // User location
    private func userLocation(user: User) -> UILabel {
        let label = UILabel()
        label.text = user.zipCode
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.lightGray.cgColor
        return label
    }
    
    // Sports preferences label
    private let sportsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sports Preferences:"
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    //TODO
    // User's sports preferences
    private func userSports(user: User) -> UILabel {
        let label = UILabel()
        //label.text = user.sportsPreferences
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.lightGray.cgColor
        return label
    }
    
    // Edit Profile button
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    // Sign out button
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    // Add friends button
    private let addFirendsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Friends", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    // Block users button
    private let blockUsersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Block Users", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    // My friends button
    private let myFriendsButton: UIButton = {
        let button = UIButton()
        button.setTitle("My firends", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    // Suggestions button
    private let suggestionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Suggestions", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = userAuth.currUser!
        view.backgroundColor = .white
        
        // Get user's info
        let name = userName(user:user)
        let location = userLocation(user: user)
        let sportsPreferences = userSports(user: user)
        
        // Functionality for the buttons
        editProfileButton.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
        
        addFirendsButton.addTarget(self, action: #selector(addFriendsTapped), for: .touchUpInside)
        
        myFriendsButton.addTarget(self, action: #selector(myFriendsTapped), for: .touchUpInside)
        
        blockUsersButton.addTarget(self, action: #selector(blockUsersTapped), for: .touchUpInside)
        
        suggestionsButton.addTarget(self, action: #selector(suggestionsTapped), for: .touchUpInside)
        
        signOutButton.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
        
        // Add subviews to view
        view.addSubview(scrollView)
        scrollView.addSubview(picView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(name)
        scrollView.addSubview(locLabel)
        scrollView.addSubview(location)
        scrollView.addSubview(sportsLabel)
        scrollView.addSubview(sportsPreferences)
        scrollView.addSubview(editProfileButton)
        scrollView.addSubview(addFirendsButton)
        scrollView.addSubview(myFriendsButton)
        scrollView.addSubview(blockUsersButton)
        scrollView.addSubview(suggestionsButton)
        scrollView.addSubview(signOutButton)
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width / 1.3
        picView.frame = CGRect(x: 120,
                               y: 70,
                               width: scrollView.width / 2.5,
                               height: scrollView.width / 2.5)
        nameLabel.frame = CGRect(x: 40,
                                 y: picView.bottom + 20,
                                 width: 53,
                                 height: 20)
        locLabel.frame = CGRect(x: 40,
                                y: nameLabel.bottom + 20,
                                 width: 74,
                                 height: 20)
        sportsLabel.frame = CGRect(x: 40,
                                y: locLabel.bottom + 20,
                                 width: 159,
                                 height: 20)
        editProfileButton.frame = CGRect(x: 90,
                                    y: sportsLabel.bottom + 60,
                                    width: 225,
                                    height: 50)
        addFirendsButton.frame = CGRect(x: 90,
                                        y: editProfileButton.bottom + 30,
                                        width: 225,
                                        height: 50)
        myFriendsButton.frame = CGRect(x: 90,
                                        y: addFirendsButton.bottom + 30,
                                        width: 225,
                                        height: 50)
        blockUsersButton.frame = CGRect(x: 90,
                                        y: myFriendsButton.bottom + 30,
                                        width: 225,
                                        height: 50)
        suggestionsButton.frame = CGRect(x: 90,
                                        y:blockUsersButton.bottom + 30,
                                        width: 225,
                                        height: 50)
        signOutButton.frame = CGRect(x: 90,
                                    y: suggestionsButton.bottom + 30,
                                    width: 225,
                                    height: 50)
    }
    
    // Edit profile clicked
    @objc private func editProfileTapped() {
        // Try to do uinavigation controller
    }
    
    // Add friends clicked
    @objc private func addFriendsTapped() {
        
    }
    
    // My friends clicked
    @objc private func myFriendsTapped() {
        
    }
    
    // Block users clicked
    @objc private func blockUsersTapped() {
        
    }
    
    // Suggestions clicked
    @objc private func suggestionsTapped() {
        
    }
    
    // sign out clicked
    @objc private func signOutTapped() {
        
    }
}

#Preview() {
    ProfileViewController()
}
