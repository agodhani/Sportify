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
import UIKit
//cell view criteria
import UIKit

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
class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var userAuth: UserAuthentication?
    
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage(named: "SportifyLogoOriginal")
        logoView.tintColor = .yellow
        logoView.contentMode = .scaleAspectFit
        return logoView
    }()
    
    //table and tableview criteria
    private let table: UITableView = {
        let table = UITableView()
        table.register(MessageTableViewCell.self, forCellReuseIdentifier: "MessageCellIdentifier")
        return table
    }()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCellIdentifier", for: indexPath) as! MessageTableViewCell
        //cell.textLabel?.text = "Username"//eventz[indexPath.row].name
        cell.usernameLabel.text = "Username"
        cell.messageLabel.text = "message"
        cell.dateLabel.text = "11/10/2023"
        cell.userImageView.image = UIImage(named: "SportifyLogoOriginal")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let selectedEvent = allEvents.events[indexPath.row]
        let vc = MessageChatViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(logoView)
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        table.frame = CGRect(x: 0,
                             y: view.top, // was 50
                            width: view.width,
                            height: view.height)
    }
}

#Preview {
    MessageViewController()
}

