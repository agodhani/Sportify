//
//  ProfileViewController.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/26/23.
//

import UIKit
import SwiftUI
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
    
    // Name
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    // TODO: get user's name form db
    
    // Location
    private let locLabel: UILabel = {
        let label = UILabel()
        label.text = "Location:"
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    // TODO: get location from db
    
    // Sports preferences
    private let sportsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sports Preferences:"
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    // TODO: get sports preferences from db
    
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
        button.setTitle("SIGN OUT", for: .normal)
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
        view.backgroundColor = .white
        
        // Add subviews to view
        view.addSubview(picView)
        view.addSubview(nameLabel)
        view.addSubview(locLabel)
        view.addSubview(sportsLabel)
        view.addSubview(editProfileButton)
        view.addSubview(signOutButton)
        view.addSubview(addFirendsButton)
        view.addSubview(blockUsersButton)
        view.addSubview(myFriendsButton)
        view.addSubview(suggestionsButton)
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = view.width / 1.3
        picView.frame = CGRect(x: 120,
                               y: 70,
                               width: view.width/2.5,
                               height: view.width/2.5)
        nameLabel.frame = CGRect(x: 120,
                                 y: 70,
                                 width: view.width/2.5,
                                 height: view.width/2.5)
    }
}

#Preview() {
    ProfileViewController()
}
