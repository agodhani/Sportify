//
//  MessageChatViewController.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 11/12/23.
//
import Foundation
import UIKit

class MessageChatViewController: UIViewController {
    var userAuth: UserAuthentication?
    var chatUser: User?
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .sportGold
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    let newMessageTextField: UITextField = {
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        view.addSubview(usernameLabel)
        usernameLabel.text = chatUser?.name ?? "Username"
        NSLayoutConstraint.activate([
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        view.addSubview(newMessageTextField)
        NSLayoutConstraint.activate([
            newMessageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            newMessageTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8), // Set trailing to the centerXAnchor
            newMessageTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])

        view.addSubview(sendButton)
        NSLayoutConstraint.activate([
            sendButton.leadingAnchor.constraint(equalTo: newMessageTextField.trailingAnchor, constant: 8), // Adjust leading constraint
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
