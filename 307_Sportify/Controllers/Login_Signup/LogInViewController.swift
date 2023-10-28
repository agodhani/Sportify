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
        button.layer.cornerRadius = 15
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        loginButton.addTarget(self, action: #selector(tappedLogIn), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(tappedForgotPassword), for: .touchUpInside)
        //add subviews
        view.addSubview(logoView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(forgotPasswordButton)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        logoView.frame = CGRect(x: (view.width - size) / 2,
                                y: 100,
                                width: size,
                                height: size)
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
                let vc = EventsViewController()
                navigationController?.pushViewController(vc, animated: true)
            } else {
                print("log in failed")
            }
        }
    }
}

#Preview {
    LogInViewController()
}
