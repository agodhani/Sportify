//
//  LogInViewController.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/25/23.
//

import UIKit
import SwiftUI

class LogInViewController: UIViewController {
    @State var userAuth = UserAuthentication()
    
    // Back button
    private let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .black
        button.setTitleColor(.sportGold, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    // Logo
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage(named: "SportifyLogoOriginal")
        logoView.contentMode = .scaleAspectFit
        return logoView
    }()
    
    // Email txt field
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.placeholder = "Email Address"
        field.backgroundColor = .lightGray
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .lightGray
        field.tintColor = .black
        return field
    }()
    
    // Password txt field
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.placeholder = "Password"
        field.backgroundColor = .lightGray
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .lightGray
        field.isSecureTextEntry = true
        field.tintColor = .black
        return field
    }()
    
    // Login button
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOG IN", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        return button
    }()
    
    // Login button
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        button.setTitleColor(.sportGold, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    private var revealButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        return button
    }()
    
    private var wrongText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 15, weight: .regular)
        text.isScrollEnabled = false
        text.textColor = .red
        text.text = "Invalid email or password"
        text.isHidden = true
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Log In"
        let appearence = UINavigationBarAppearance()
        appearence.titleTextAttributes = [.foregroundColor: UIColor.sportGold]
        navigationItem.standardAppearance = appearence
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonTapped))
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        loginButton.addTarget(self, action: #selector(tappedLogIn), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(tappedForgotPassword), for: .touchUpInside)
        revealButton.addTarget(self, action: #selector(revealButtonTapped), for: .touchUpInside)
        
        //add subviews
        view.addSubview(backButton)
        view.addSubview(logoView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(revealButton)
        view.addSubview(wrongText)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        
        backButton.frame = CGRect(x: 15,
                                  y: 70,
                                  width: 70,
                                  height: 30)
        

        logoView.frame = CGRect(x: (view.width - size) / 2,
                                y: 100,
                                width: size,
                                height: size)
        wrongText.frame = CGRect(x: 108,
                                 y: logoView.bottom - 65,
                                 width: 225,
                                 height: 50)
        emailField.frame = CGRect(x: 90,
                                   y: logoView.bottom - 20,
                                   width: 225,
                                   height: 50)
        passwordField.frame = CGRect(x: 90,
                                   y: logoView.bottom + 50,
                                  width: 225,
                                  height: 50)
        loginButton.frame = CGRect(x: 90,
                                   y: logoView.bottom + 125,
                                  width: 225,
                                  height: 50)
        forgotPasswordButton.frame = CGRect(x: 90,
                                           y: logoView.bottom + 200,
                                          width: 225,
                                          height: 50)
        revealButton.frame = CGRect(x: 45,
                                    y: logoView.bottom + 50,
                                    width: 50,
                                    height: 50)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func revealButtonTapped() {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
        if (passwordField.isSecureTextEntry) {
            // if hidden
            revealButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        
        } else {
            // if not hidden
            revealButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    @objc private func tappedForgotPassword() {
        let vc = ForgotPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func tappedLogIn() {
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty else {
            print("email is empty, password is empty")
                  return
              }
        Task {
            if(try await userAuth.signIn(withEmail: email, password: password)) {
                print("log in success")
                //TODO link to new homepage
                
                let tabBarController = UITabBarController()

                let eventsViewController = UIHostingController(rootView: EventsViewControllerRepresentable())
                let notificationViewController = UIHostingController(rootView: NotificationViewControllerRepresentable())
                let homeEventsViewController = UIHostingController(rootView: HomeEventsViewControllerRepresentable(userAuth: userAuth))
                let messageViewController = UIHostingController(rootView: MessageViewControllerRepresentable(userAuth: userAuth))
                let profileViewController = UIHostingController(rootView: ProfileViewControllerRepresentable(userAuth: userAuth))
                
                eventsViewController.tabBarItem = UITabBarItem(title: "Events", image: UIImage(systemName: "calendar.badge.clock"), selectedImage: nil)
                       notificationViewController.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(systemName: "bell.badge"), selectedImage: nil)
                       homeEventsViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.circle"), selectedImage: nil)
                       messageViewController.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(systemName: "plus.message.fill"), selectedImage: nil)
                       profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: nil)
                
                tabBarController.viewControllers = [
                    eventsViewController,
                    notificationViewController,
                    homeEventsViewController,
                    messageViewController,
                    profileViewController
                ]

                   
                   // Set the UITabBarController as the root view controller
                   //UIApplication.shared.windows.first?.rootViewController = tabBarController
                   UIApplication.shared.windows.first?.makeKeyAndVisible()
                //let vc = EventsViewController()
                let vc = tabBarController
                vc.navigationItem.hidesBackButton = true

                navigationController?.pushViewController(vc, animated: true)
                //vc.navigationItem.setHidesBackButton(true, animated: true)
                //self.navigationItem.hidesBackButton = true
                //self.navigationItem.setHidesBackButton(true, animated: true)
                
            } else {
                print("log in failed")
                wrongText.isHidden = false
            }
        }
    }
}

#Preview {
    LogInViewController()
}
