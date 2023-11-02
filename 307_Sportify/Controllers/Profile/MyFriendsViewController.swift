//
//  MyFriendsViewController.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/31/23.
//

import UIKit
import SwiftUI
import Firebase

struct MyfriendsViewControllerRepresentable: UIViewControllerRepresentable {
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
}

class MyFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userAuth = UserAuthentication()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let user = userAuth.currUser
        let friends = user?.friendList
        return friends!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = userAuth.currUser
        let friends = user?.friendList
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = friends![indexPath.row]
        return cell
    }
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "My Friends"
        let appearence = UINavigationBarAppearance()
        appearence.titleTextAttributes = [.foregroundColor: UIColor.sportGold]
        navigationItem.standardAppearance = appearence
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonTapped))
        
        let user = userAuth.currUser
        let friends = user?.friendList
        table.dataSource = self
        table.delegate = self
        
        view.addSubview(table)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        table.frame = CGRect(x: 10,
                             y: 20,
                             width: view.width - 20,
                             height: view.height - 20)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.dismiss(animated: true)
    }
    
}
