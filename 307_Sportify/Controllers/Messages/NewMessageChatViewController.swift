//
//  NewMessageChatViewController.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 11/20/23.
//

//
//  AddFriendsViewController.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 11/9/23.
//

import UIKit
import SwiftUI
import Firebase

struct NewMessageChatViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = NewMessageChatViewController
    var userAuth: UserAuthentication
    
    
    func makeUIViewController(context: Context) -> NewMessageChatViewController {
        let vc = NewMessageChatViewController()
        // Do some configurations here if needed.
        vc.userAuth = userAuth
        return vc
    }
    
    func updateUIViewController(_ uiViewController: NewMessageChatViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
        
    }
}


class NewMessageChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var userAuth : UserAuthentication?
    var userm = UserMethods()
    var friendsListAsUsers = [User].self
    
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    //Table information
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let user = userAuth?.currUser
        var ids = user?.friendList ?? []
        let messageList = user?.messageList ?? []
        ids = ids.filter({id in
            !messageList.contains(id)})
        return ids.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        Task {
            let user = userAuth?.currUser
            var ids = user?.friendList ?? []
            let messageList = user?.messageList ?? []
            ids = ids.filter({id in
                !messageList.contains(id)})
            let friend = await userm.getUser(user_id: ids[indexPath.row])
            cell.textLabel?.text = friend.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MessageChatViewController()
        vc.userAuth = userAuth
        Task {
            var user = userAuth?.currUser
            var ids = user?.friendList ?? []
            let messageList = user?.messageList ?? []
            ids = ids.filter({id in
                !messageList.contains(id)})
            let friend = await userm.getUser(user_id: ids[indexPath.row])
            vc.chatUser = friend
            user?.messageList.append(friend.id)
            var userID = (user?.id)!
            let db = Firestore.firestore()
            await userAuth?.getCurrUser()
            try await db.collection("Users").document(userID).updateData(["messageList": user?.messageList ?? []])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await userAuth?.getCurrUser()
            table.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        table.reloadData()
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = CGRect(x: 0,
                                 y: 200, // was 50
                                 width: view.width,
                                 height: view.height)
        
    }
    
}
