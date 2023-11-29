//
//  NotificationPreferencesViewController.swift
//  307_Sportify
//
//  Created by Alexandre Cunha on 11/20/23.
//

import UIKit
import Firebase

class NotificationPreferencesViewController: UIViewController {
    
    var userAuth = UserAuthentication()

    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage(named: "SportifyLogoOriginal")
        logoView.contentMode = .scaleAspectFit
        return logoView
    }()
    
    private let notificationsText: UITextView = {
        let text = UITextView()
        text.text = "Notifications"
        text.backgroundColor = .black
        text.textColor = .white
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 30, weight: .semibold)
        return text
    }()
    
    private let generalNotificationsText: UITextView = {
        let text = UITextView()
        text.text = "General Notifications"
        text.textColor = .white
        text.backgroundColor = .black
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private let generalNotificationsSlider: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    private let dmNotificationsText: UITextView = {
        let text = UITextView()
        text.text = "DM Notifications"
        text.textColor = .white
        text.backgroundColor = .black
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private let dmNotificationsSlider: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    private let eventNotificationsText: UITextView = {
        let text = UITextView()
        text.text = "Event Notifications"
        text.textColor = .white
        text.backgroundColor = .black
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private let eventNotificationsSlider: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    private let friendRequestNotificationsText: UITextView = {
        let text = UITextView()
        text.text = "Friend Request Notifications"
        text.textColor = .white
        text.backgroundColor = .black
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private let friendRequestNotificationsSlider: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    private let updatePreferencesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update Preferences", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let user = userAuth.currUser else {
            print("userAuth.currUser failed")
            return
        }
        
        generalNotificationsSlider.isOn = user.generalNotifications
        dmNotificationsSlider.isOn = user.dmNotifications
        eventNotificationsSlider.isOn = user.eventNotifications
        friendRequestNotificationsSlider.isOn = user.friendRequestNotifications
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // Add subviews
        view.addSubview(logoView)
        view.addSubview(notificationsText)
        view.addSubview(generalNotificationsText)
        view.addSubview(generalNotificationsSlider)
        view.addSubview(dmNotificationsText)
        view.addSubview(dmNotificationsSlider)
        view.addSubview(eventNotificationsText)
        view.addSubview(eventNotificationsSlider)
        view.addSubview(friendRequestNotificationsText)
        view.addSubview(friendRequestNotificationsSlider)
        view.addSubview(updatePreferencesButton)
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        
        logoView.frame = CGRect(x: (view.width - size) / 2,
                                y: -10,
                                width: size,
                                height: size)
        notificationsText.frame = CGRect(x: 5,
                                         y: logoView.bottom - 50,
                                         width: view.width,
                                         height: 40)
        
        generalNotificationsText.frame = CGRect(x: 25,
                                                y: notificationsText.bottom + 50,
                                                width: view.width,
                                                height: 30)
        generalNotificationsSlider.frame = CGRect(x: 315,
                                                  y: notificationsText.bottom + 55,
                                                  width: view.width,
                                                  height: 20)
        dmNotificationsText.frame = CGRect(x: 25,
                                                y: generalNotificationsText.bottom + 40,
                                                width: view.width,
                                                height: 30)
        dmNotificationsSlider.frame = CGRect(x: 315,
                                                  y: generalNotificationsText.bottom + 45,
                                                  width: view.width,
                                                  height: 20)
        eventNotificationsText.frame = CGRect(x: 25,
                                                y: dmNotificationsText.bottom + 40,
                                                width: view.width,
                                                height: 30)
        eventNotificationsSlider.frame = CGRect(x: 315,
                                                  y: dmNotificationsText.bottom + 45,
                                                  width: view.width,
                                                  height: 20)
        friendRequestNotificationsText.frame = CGRect(x: 25,
                                                y: eventNotificationsText.bottom + 40,
                                                width: view.width,
                                                height: 30)
        friendRequestNotificationsSlider.frame = CGRect(x: 315,
                                                  y: eventNotificationsText.bottom + 45,
                                                  width: view.width,
                                                  height: 20)
        updatePreferencesButton.frame = CGRect(x: 90,
                                    y: friendRequestNotificationsText.bottom + 70,
                                    width: 225,
                                    height: 50)
    }
    
    // Update db
    @objc private func updatePreferencesTapped() {
        let db = Firestore.firestore()
        let user_id = userAuth.currUser?.id ?? ""
        var currUser = userAuth.currUser
        currUser?.generalNotifications = generalNotificationsSlider.isOn
        currUser?.dmNotifications = dmNotificationsSlider.isOn
        currUser?.eventNotifications = eventNotificationsSlider.isOn
        currUser?.friendRequestNotifications = friendRequestNotificationsSlider.isOn
        
        db.collection("Users").document(user_id).updateData(["generalNotifications": generalNotificationsSlider.isOn, "dmNotifications": dmNotificationsSlider.isOn, "eventNotifications": eventNotificationsSlider.isOn, "friendRequestNotifications": friendRequestNotificationsSlider.isOn])
    }
}

#Preview {
    NotificationPreferencesViewController()
}
