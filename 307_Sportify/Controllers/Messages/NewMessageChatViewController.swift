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
        allUsers.getUsers()
        let vc = NewMessageChatViewController()
        // Do some configurations here if needed.
        vc.userAuth = userAuth
        return vc
    }
    
    func updateUIViewController(_ uiViewController: NewMessageChatViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
        
    }
}


class NewMessageChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var userAuth : UserAuthentication?
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    //Table information
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var user = userAuth?.currUser
        var counter = user?.friendList.count ?? 0
        return counter
        
    }
    //filter table views
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var user = userAuth?.currUser
        user?.friendList[indexPath.row]
        cell.textLabel?.text =
            cell.textLabel?.text = userz[indexPath.row].name
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (filterLocation || filterSportPreferences) {
            let selectedUser = allUsers.filteredUsers[indexPath.row]
            let vc = UserProfileViewController()
            vc.userAuth = userAuth
            vc.person = selectedUser
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let selectedUser = allUsers.users[indexPath.row]
            let vc = UserProfileViewController()
            vc.userAuth = userAuth
            vc.person = selectedUser
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        allUsers.getUsers()
        table.dataSource = self
        table.delegate = self
        allUsers.delegate = self
        sportPicker.delegate = self
        sportPicker.dataSource = self
        sportPicker.selectRow(16, inComponent: 0, animated: false)
        view.addSubview(locationLabel)
        view.addSubview(filterLocationSlider)
        view.addSubview(sportPicker)
        view.addSubview(table)
        filterLocationSlider.addTarget(self, action: #selector(switchLocationSliderChanged), for: .valueChanged)
        
    }
    func usersDidUpdate() {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        view.frame = view.bounds
        view.backgroundColor = .black
        locationLabel.frame = CGRect(x: 50,
                                    y: 95,
                                    width: size,
                                    height: 50)
        filterLocationSlider.frame = CGRect(x: 150,
                                       y: 100,
                                       width: 1,
                                       height: 1)
        table.frame = CGRect(x: 0,
                             y: 240, // was 50
                             width: view.width,
                             height: view.height)
        sportPicker.frame = CGRect(x: 150,
                                    y: 180,
                                    width: 150,
                                    height: 50)
    }
    
}
