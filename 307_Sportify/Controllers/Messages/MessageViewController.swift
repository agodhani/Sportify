//
//  MessageViewController.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/27/23.
//

import UIKit
import SwiftUI

struct MessageViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = MessageViewController
    var userAuth: UserAuthentication
    
    init(userAuth: UserAuthentication) {
        self.userAuth = userAuth
    }
    func makeUIViewController(context: Context) -> MessageViewController {
        let vc = MessageViewController()
        vc.userAuth = userAuth
        // Do some configurations here if needed.
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MessageViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}
protocol UserMethodsDelegate: AnyObject {
    func usersDidUpdate()
}

class MessageTableViewCell: UITableViewCell {
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit 
        return imageView
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
            let label = UILabel()
            label.textColor = .gray
            label.font = UIFont.systemFont(ofSize: 11)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(userImageView)
        addSubview(usernameLabel)
        addSubview(messageLabel)
        addSubview(dateLabel)
        usernameLabel.textColor = .sportGold
        messageLabel.textColor = .gray

        NSLayoutConstraint.activate([
                    userImageView.topAnchor.constraint(equalTo: topAnchor, constant: -8),
                    userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                    userImageView.widthAnchor.constraint(equalToConstant: 80),
                    userImageView.heightAnchor.constraint(equalToConstant: 80),
                    usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                    usernameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),

                    dateLabel.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor),
                    dateLabel.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: 8),
                    dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

                    messageLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
                    messageLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
                    messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                    messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//messaging view controller
class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UserMethodsDelegate {
    var userAuth: UserAuthentication?
    var userm = UserMethods()
    var messageListasUsers: [User]?
    
    func usersDidUpdate() {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    
    private let newMessage: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.setTitle("New Message", for: .normal)
        button.backgroundColor = .sportGold
        return button
    }()
    
    @objc private func tappedNewMessageButton() {
        let vc = NewMessageChatViewController()
        vc.userAuth = userAuth
        navigationController?.pushViewController(vc, animated: true)
    }
    //table and tableview criteria
    private let table: UITableView = {
        let table = UITableView()
        table.register(MessageTableViewCell.self, forCellReuseIdentifier: "MessageCellIdentifier")
        return table
    }()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let user = userAuth?.currUser
        let messages = user?.messageList ?? []
        return messages.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCellIdentifier", for: indexPath) as! MessageTableViewCell
        //cell.textLabel?.text = "Username"//eventz[indexPath.row].name
        cell.usernameLabel.text = messageListasUsers?[indexPath.row].name
        cell.messageLabel.text = "message"
        cell.dateLabel.text = "11/10/2023"
        cell.userImageView.image = UIImage(named: "SportifyLogoOriginal")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let selectedEvent = allEvents.events[indexPath.row]
        let vc = MessageChatViewController()
        vc.userAuth = userAuth
        vc.chatUser = messageListasUsers?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Task{
            await userAuth?.getCurrUser()
            let messageList = userAuth?.currUser?.messageList ?? []
            messageListasUsers = await userm.messageListAsUsers(messageList: messageList)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task{
            let messageList = userAuth?.currUser?.messageList ?? []
            messageListasUsers = await userm.messageListAsUsers(messageList: messageList)
        }
        view.backgroundColor = .white
        view.addSubview(table)
        view.addSubview(newMessage)
        userm.delegate = self
        table.dataSource = self
        table.delegate = self
        newMessage.addTarget(self, action: #selector(tappedNewMessageButton), for: .touchUpInside)
        table.reloadData()

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //let size = view.width / 1.2
        table.frame = CGRect(x: 0,
                             y: 55, // was 50
                            width: view.width,
                            height: view.height)
        newMessage.frame = CGRect(x: view.right - 100,
                                  y: view.top,
                                       width: 100,
                                       height: 50)
    }
}

#Preview {
    MessageViewController()
}

