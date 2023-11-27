//
//  MessageChatViewController.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 11/12/23.
//
import Foundation
import UIKit
import Firebase

struct MessageInfo {
    let fromId, toId, text: String
    let date: Date
}

class FromUserCell: UITableViewCell {
    static let reuseIdentifier = "FromUser"

    let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .sportyGold
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            bubbleView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),

            messageLabel.topAnchor.constraint(greaterThanOrEqualTo: bubbleView.topAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -8),
            messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: bubbleView.bottomAnchor, constant: -8),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 8),
            messageLabel.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor) // Center the label vertically
        ])

        // Content hugging and compression resistance priorities
        messageLabel.setContentHuggingPriority(.required, for: .vertical)
        messageLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Ensure that the cell can grow vertically to accommodate multiline text
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        let size = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: UIView.noIntrinsicMetric, height: size.height)
    }
    
    func configure(with text: String) {
        messageLabel.text = text
    }
}



class ToUserCell: UITableViewCell {
    static let reuseIdentifier = "ToUser"

    let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .black
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            bubbleView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),

            messageLabel.topAnchor.constraint(greaterThanOrEqualTo: bubbleView.topAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: bubbleView.bottomAnchor, constant: -8),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -8),
            messageLabel.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor) // Center the label vertically
        ])

        // Content hugging and compression resistance priorities
        messageLabel.setContentHuggingPriority(.required, for: .vertical)
        messageLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Ensure that the cell can grow vertically to accommodate multiline text
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        let size = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: UIView.noIntrinsicMetric, height: size.height)
    }
    
    func configure(with text: String) {
        messageLabel.text = text
    }
}



class MessageChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var userAuth: UserAuthentication?
    var chatUser: User?
    let db = Firestore.firestore()
    var messages = [MessageInfo]()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .sportGold
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    let chatField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "New Message"
        textField.borderStyle = .roundedRect
        return textField
    }()

    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: .normal)
        return button
    }()
    private func fetchMessages() {
        let fromId = userAuth?.currUser?.id ?? ""
        let toId = chatUser?.id ?? ""
        db.collection("Messages").document(fromId).collection(toId).order(by: "date")
            .addSnapshotListener{querySnapshot, error in
                if let error = error {
                    print("Failed to fetch messags")
                    print(error.localizedDescription)
                    return
                }
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
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
                        self.messages.append(messageInfo)
                        self.table.reloadData()
                        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                        self.table.scrollToRow(at: indexPath, at: .bottom, animated: true)
                        //add notification for each added message here
                    }
                })
                
                /*
                querySnapshot?.documents.forEach({ queryDocumentSnapshot in
                    let data = queryDocumentSnapshot.data()
                    let messageInfo = MessageInfo(fromId: data["fromId"] as! String, toId: data["tiId"] as! String,
                                              text: data["message"] as! String, date: data["date"] as! String)
                    self.messages.append(messageInfo)
                })
                 */
            }
        
    }
    @objc private func tappedSendButton() {
        if(!chatField.hasText) {
            return
        }
        let fromId = userAuth?.currUser?.id ?? ""
        let toId = chatUser?.id ?? ""
        let senderDocument = db.collection("Messages").document(toId).collection(fromId).document()
        let recieverDocument = db.collection("Messages").document(fromId).collection(toId).document()
        let textInfo = ["fromId": fromId, "toId": toId, "message": self.chatField.text, "date": Date.now] as [String : Any]
        if(messages.count > 2) {
            let indexPath = IndexPath(row: messages.count - 1, section: 0)
            table.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        senderDocument.setData(textInfo) { error in
            if let error = error {
                print("Sender message failed to save in Firestore")
                return
            }
        }
        recieverDocument.setData(textInfo) { error in
            if let error = error {
                print("Reciever essage failed to save in Firestore")
                return
            }
        }
        print(chatField.text)
        chatField.text = ""
    }
    
    
    //table and tableview criteria
    private let table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userID = userAuth?.currUser?.id ?? ""
        if messages[indexPath.row].fromId == userID {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FromUser", for: indexPath) as! FromUserCell
            cell.configure(with: messages[indexPath.row].text)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToUser", for: indexPath) as! ToUserCell
            cell.configure(with: messages[indexPath.row].text)
            return cell
        }
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
        //        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        //backButton.frame = CGRect(x: 10, y: 60, width: 70, height: 30)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backButton.frame = CGRect(x: 10, y: 60, width: 70, height: 30)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMessages()
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.backgroundColor = .black
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.register(FromUserCell.self, forCellReuseIdentifier: "FromUser")
        table.register(ToUserCell.self, forCellReuseIdentifier: "ToUser")
        table.backgroundColor = .black
        NSLayoutConstraint.activate([
                table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
                table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
            ])

        view.addSubview(usernameLabel)
        usernameLabel.text = chatUser?.name ?? "Username"
        NSLayoutConstraint.activate([
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        view.addSubview(chatField)
        NSLayoutConstraint.activate([
            chatField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            chatField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8), // Set trailing to the centerXAnchor
            chatField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])

        view.addSubview(sendButton)
        sendButton.addTarget(self, action: #selector(tappedSendButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            sendButton.leadingAnchor.constraint(equalTo: chatField.trailingAnchor, constant: 8), // Adjust leading constraint
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
