//
//  MessageViewController.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/27/23.
//

import UIKit
import SwiftUI
import Firebase

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
        
        contentView.backgroundColor = .black
        addSubview(userImageView)
        addSubview(usernameLabel)
        addSubview(messageLabel)
        addSubview(dateLabel)
        usernameLabel.textColor = .sportGold
        messageLabel.textColor = .systemGray2
        dateLabel.textColor = .systemGray2
        

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
    var lastMessages = [MessageInfo]()
    func usersDidUpdate() {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    
    private let newMessage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.cornerRadius = button.frame.size.width / 2
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
        if(messageListasUsers != nil && lastMessages.count != 0 && lastMessages.count == userAuth?.currUser?.messageList.count) {
            let combined = zip(lastMessages, messageListasUsers ?? [])
            let sortedCombined = combined.sorted { $0.0.date > $1.0.date }
            lastMessages = sortedCombined.map { $0.0 }
            messageListasUsers = sortedCombined.map { $0.1 }
            lastMessages = lastMessages.sorted(by: { $0.date > $1.date })
        }
        cell.usernameLabel.text = messageListasUsers?[indexPath.row].name
        if((lastMessages.count == messageListasUsers?.count ?? -1) ) {
            cell.messageLabel.text = lastMessages[indexPath.row].text
            cell.dateLabel.text = lastMessages[indexPath.row].date.formatted()
        } else {
            cell.messageLabel.text = "error message loading"
            cell.dateLabel.text = "date"
        }
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
            lastMessages.removeAll()
            await userAuth?.getCurrUser()
            let messageList = userAuth?.currUser?.messageList ?? []
            messageListasUsers = await userm.messageListAsUsers(messageList: messageList)
            let db = Firestore.firestore()
            let userID = userAuth?.currUser?.id ?? ""
            for messageID in messageList {
                db.collection("Messages").document(userID).collection(messageID).order(by: "date", descending: true).limit(to: 1)
                    .addSnapshotListener{querySnapshot, error in
                        if let error = error {
                            print("Failed to fetch messags")
                            print(error.localizedDescription)
                            return
                        }
                        
                        querySnapshot?.documents.forEach({ queryDocumentSnapshot in
                            let data = queryDocumentSnapshot.data()
                            let fromId = data["fromId"] as! String
                            let toId = data["toId"] as! String
                            let text = data["message"] as! String
                            let date: Date
                            if let timestamp = data["date"] as? Timestamp {
                                date = timestamp.dateValue()
                            } else if let dateValue = data["date"] as? Date {
                                date = dateValue
                            } else {
                                date = Date()
                            }
                            let messageInfo = MessageInfo(fromId: fromId, toId: toId, text: text, date: date)
                            if(messageList.contains(fromId) && self.lastMessages.count == messageList.count) {
                                let indexs = self.messageListasUsers?.firstIndex(where: { User in
                                    User.id == fromId
                                })
                                self.lastMessages[indexs ?? 0] = messageInfo
                            } else {
                                self.lastMessages.append(messageInfo)
                            }
                            self.table.reloadData()
                        })
                        self.table.reloadData()

                    }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task{
            let messageList = userAuth?.currUser?.messageList ?? []
            messageListasUsers = await userm.messageListAsUsers(messageList: messageList)
        }
        view.backgroundColor = .black
        table.backgroundColor = .black
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

