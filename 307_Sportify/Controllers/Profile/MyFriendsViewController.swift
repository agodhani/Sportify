//
//  MyFriendsViewController.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/31/23.
//

import UIKit
import SwiftUI
import Firebase

/*struct MyfriendsViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = MyFriendsViewController
    @ObservedObject var allEvents = AllEvents()
    var userAuth: UserAuthentication
    
    init(userAuth: UserAuthentication) {
        self.userAuth = userAuth
    }
    
    func makeUIViewController(context: Context) -> MyFriendsViewController {
        let vc = MyFriendsViewController()
        // Do some configurations here if needed.
        vc.userAuth = userAuth
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MyFriendsViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
        
    }
}*/

class MyFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userAuth = UserAuthentication()
    var eventm = EventMethods()
    var userm = UserMethods()
    var friendIDs = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let user = userAuth.currUser
        friendIDs = user?.friendList ?? []
        return friendIDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        Task {
            let user = userAuth.currUser
            let ids = user?.friendList ?? []
            var friend = await userm.getUser(user_id: ids[indexPath.row])
            cell.textLabel?.text = friend.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let currUser = userAuth.currUser
        let selectedUserID = friendIDs[indexPath.row]
        
        let alertController = UIAlertController(title: "Alert", message: "Choose an action:", preferredStyle: .alert)
        
        // give option to invite
        let inviteAction = UIAlertAction(title: "Invite to event", style: .default) { _ in
            Task {
                let vc = InviteToEventViewController()
                var eventsAsEvents = [Event]()
                for eventid in currUser!.eventsAttending {
                    let realEvent = await self.eventm.getEvent(eventID: eventid)
                    eventsAsEvents.append(realEvent)
                }
                vc.eventsAttending = eventsAsEvents
                vc.userInvitingID = selectedUserID
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
        // give option to remove friend
        let removeFriendAction = UIAlertAction(title: "Remove friend", style: .destructive) { _ in
            
        }
        
        alertController.addAction(inviteAction)
        alertController.addAction(removeFriendAction)
        self.present(alertController, animated: true)
    }
    
    private var myFriendsText: UITextView = {
        let text = UITextView()
        
        let attributedString = NSMutableAttributedString.init(string: "MY FRIENDS")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor(white: 1, alpha: 1), range: NSRange.init(location: 0, length: attributedString.length))
        text.attributedText = attributedString
        
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 40, weight: .bold)
        text.toggleUnderline(true)
        text.isEditable = false
        text.isSelectable = false
        return text
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await userAuth.getCurrUser()
            self.friendIDs = userAuth.currUser?.friendList ?? []
            self.tableView.reloadData()
        }
        
        view.backgroundColor = .black
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        view.addSubview(myFriendsText)
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
        
        myFriendsText.frame = CGRect(x: (view.width - size) / 2,
                                    y: 80, // was 50
                                    width: size,
                                    height: size)
        
        tableView.frame = CGRect(x: 0,
                                 y: 200, // was 50
                                 width: view.width,
                                 height: view.height)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.dismiss(animated: true)
    }
    
}

#Preview {
    MyFriendsViewController()
}
