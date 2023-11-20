//
//  NotificationPreferencesViewController.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 11/20/23.
//

import UIKit

class NotificationPreferencesViewController: UIViewController {

    private let notificationsText: UITextView = {
        let text = UITextView()
        text.text = "Notifications"
        text.backgroundColor = .black
        text.textColor = .white
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 20, weight: .semibold)
        return text
    }()
    
    private let generalNotificationsText: UITextView = {
        let text = UITextView()
        text.text = "General Notifications"
        text.textColor = .white
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private let dmNotificationsText: UITextView = {
        let text = UITextView()
        text.text = "DM Notifications"
        text.textColor = .white
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private let eventNotificationsText: UITextView = {
        let text = UITextView()
        text.text = "Event Notifications"
        text.textColor = .white
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private let friendRequestNotificationsText: UITextView = {
        let text = UITextView()
        text.text = "Friend Request Notifications"
        text.textColor = .white
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // Add subviews
        view.addSubview(notificationsText)
        view.addSubview(generalNotificationsText)
        view.addSubview(dmNotificationsText)
        view.addSubview(eventNotificationsText)
        view.addSubview(friendRequestNotificationsText)
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        notificationsText.frame = CGRect(x: 134,
                                         y: 60,
                                         width: 135,
                                         height: 40)
        
        generalNotificationsText.frame = CGRect(x: 45,
                                                y: notificationsText.bottom + 40,
                                                width: view.width,
                                                height: 25)
        dmNotificationsText.frame = CGRect(x: 45,
                                                y: generalNotificationsText.bottom + 40,
                                                width: view.width,
                                                height: 25)
        eventNotificationsText.frame = CGRect(x: 45,
                                                y: dmNotificationsText.bottom + 40,
                                                width: view.width,
                                                height: 25)
        friendRequestNotificationsText.frame = CGRect(x: 45,
                                                y: eventNotificationsText.bottom + 40,
                                                width: view.width,
                                                height: 25)
    }
}

#Preview {
    NotificationPreferencesViewController()
}
