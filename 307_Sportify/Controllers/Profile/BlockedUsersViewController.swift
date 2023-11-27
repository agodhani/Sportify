//
//  BlockedUsersViewController.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 11/25/23.
//


import UIKit
import SwiftUI
import Firebase


class BlockedUsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UserMethodsDelegate {
    
    var userAuth : UserAuthentication?
    let userm = UserMethods()
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    //Table information
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAuth?.currUser?.blockList.count ?? 0
    }
    //filter table views
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let userID = userAuth?.currUser?.blockList[indexPath.row] ?? ""
        Task {
            let blockeduser = await userm.getUser(user_id: userID)
            cell.textLabel?.text = blockeduser.name
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currUser = userAuth?.currUser
        let selectedUserID = currUser?.blockList[indexPath.row] ?? ""
        Task {
            let vc = UserProfileViewController()
            vc.userAuth = self.userAuth
            let selectedUser = await self.userm.getUser(user_id: selectedUserID)
            var person = Person(id: selectedUser.id, name: selectedUser.name, zipCode: selectedUser.zipCode, sportPreferences: Array(selectedUser.sportsPreferences))
            vc.person = person
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        userm.delegate = self
        view.addSubview(table)
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
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
        table.frame = CGRect(x: 0,
                             y: 240, // was 50
                             width: view.width,
                             height: view.height)
        backButton.frame = CGRect(x: 10, y: 60, width: 70, height: 30)
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
    }
    
}

