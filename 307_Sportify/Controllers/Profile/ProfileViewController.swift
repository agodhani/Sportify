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
    var userAuth: UserAuthentication
    
    init(userAuth: UserAuthentication) {
        self.userAuth = userAuth
    }
    
    func makeUIViewController(context: Context) -> ProfileViewController {
        let vc = ProfileViewController()
        // Do some configurations here if needed.
        vc.userAuth = userAuth
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
        
    }
}

class ProfileViewController: UIViewController {

    var userAuth = UserAuthentication()
    let db = Firestore.firestore()
    var name = UILabel()
    var location = UILabel()
    var sportsPreferences = UILabel()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 50)
        return scrollView
    }()
    
    // Profile picture
    private var picView: UIImageView = {
        let picView = UIImageView()
        //picView.image = UIImage(systemName: "person.circle")
        picView.layer.masksToBounds = true
        picView.contentMode = .scaleAspectFit
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
        return label
    }()
    
    // User name
    private func userName(user: User) -> UILabel {
        let label = UILabel()
        label.text = user.name
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
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
    private let addFriendsButton: UIButton = {
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
        button.setTitle("My friends", for: .normal)
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
    
    func downloadPic(picView: UIImageView, url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                picView.image = image
            }
        }).resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //let userAuth = UserAuthentication()
        //self.name.text = userAuth.currUser?.name
        
        guard let user = userAuth.currUser else {
            print("userAuth.currUser failed!")
            return
        }
        let user_email = userAuth.currUser?.email
        
        // modify email to tie up user to their profile pic in db
        var safeEmail: String {
            var safeEmail = user_email?.replacingOccurrences(of: ".", with: "-")
            safeEmail = user_email?.replacingOccurrences(of: "@", with: "-")
            return safeEmail!
        }
        let picPath = "profilePictures/" + safeEmail + "_profile_picture.png"
        
        // get pic from db
        StorageManager.shared.downloadUrl(for: picPath, completion: { result in
            switch result {
            case.success(let url):
                self.downloadPic(picView: self.picView, url: url)
            case.failure(let error):
                print("failed to get url: \(error)")
                DispatchQueue.main.async {
                    let image = UIImage(systemName: "person.circle")
                    self.picView.image = image
                }
            }
        })
//        DispatchQueue.main.async {
//            self.name.text = user.name
//            self.location.text = user.zipCode
//            //sportsPreferences = userSports(user: user)
//        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        guard let user = userAuth.currUser else {
            print("userAuth.currUser failed!")
            return
        }
//        let user_email = userAuth.currUser?.email
//        
//        // modify email to tie up user to their profile pic in db
//        var safeEmail: String {
//            var safeEmail = user_email?.replacingOccurrences(of: ".", with: "-")
//            safeEmail = user_email?.replacingOccurrences(of: "@", with: "-")
//            return safeEmail!
//        }
//        let picPath = "profilePictures/" + safeEmail + "_profile_picture.png"
//        
//        // get pic from db
//        StorageManager.shared.downloadUrl(for: picPath, completion: { result in
//            switch result {
//            case.success(let url):
//                self.downloadPic(picView: self.picView, url: url)
//            case.failure(let error):
//                print("failed to get url: \(error)")
//            }
//        })
                
        // Get user's info as labels
        name = userName(user: user)
        location = userLocation(user: user)
//        sportsPreferences = userSports(user: user)
        
        // Functionality for the buttons
        editProfileButton.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
        
        addFriendsButton.addTarget(self, action: #selector(addFriendsTapped), for: .touchUpInside)
        
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
        scrollView.addSubview(addFriendsButton)
        scrollView.addSubview(myFriendsButton)
        scrollView.addSubview(blockUsersButton)
        scrollView.addSubview(suggestionsButton)
        scrollView.addSubview(signOutButton)
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        //let size = scrollView.width / 1.3
        picView.frame = CGRect(x: 120,
                               y: 30,
                               width: scrollView.width / 2.5,
                               height: scrollView.width / 2.5)
        picView.layer.cornerRadius = picView.width / 2
        nameLabel.frame = CGRect(x: 40,
                                 y: picView.bottom + 20,
                                 width: 53,
                                 height: 20)
        name.frame = CGRect(x: nameLabel.right + 5,
                                 y: picView.bottom + 20,
                            width: scrollView.width,
                                 height: 20)
        locLabel.frame = CGRect(x: 40,
                                y: nameLabel.bottom + 20,
                                 width: 74,
                                 height: 20)
        location.frame = CGRect(x: locLabel.right + 5,
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
        addFriendsButton.frame = CGRect(x: 90,
                                        y: editProfileButton.bottom + 30,
                                        width: 225,
                                        height: 50)
        myFriendsButton.frame = CGRect(x: 90,
                                        y: addFriendsButton.bottom + 30,
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
        let vc = EditProfileViewController()
        vc.picView.image = picView.image
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    // Add friends clicked
    @objc private func addFriendsTapped() {
        let vc = AddFriendsViewController()
        vc.userAuth = userAuth
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // My friends clicked
    @objc private func myFriendsTapped() {
        let vc = MyFriendsViewController()
        //let nav = UINavigationController(rootViewController: vc)
        //nav.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Block users clicked
    @objc private func blockUsersTapped() {
        
    }
    
    // Suggestions clicked
    @objc private func suggestionsTapped() {
        
    }
    
    // Sign out clicked
    @objc private func signOutTapped() {
        
    }
}

#Preview() {
    ProfileViewController()
}
