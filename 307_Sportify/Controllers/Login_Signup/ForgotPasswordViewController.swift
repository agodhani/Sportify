//
//  ForgotPasswordViewController.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/25/23.
//

import Foundation
import UIKit
import SwiftUI

class ForgotPasswordViewController: UIViewController {
    
    @State var userAuth = UserAuthentication()
    
    // Logo
    private var logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage(named: "SportifyLogoOriginal")
        logoView.contentMode = .scaleAspectFit
        return logoView
    }()
    
    private var statusText: UITextView = {
        let statusText = UITextView()
        statusText.text = "Input your associated account email"
        statusText.textColor = .white
        statusText.backgroundColor = .clear
        statusText.textAlignment = .center
        statusText.font = .systemFont(ofSize: 18, weight: .medium)
        statusText.isEditable = false
        return statusText
    }()
    
    private var emailField: UITextField = {
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
    }() // to get the value of email -> var email = emailField.text
    
    private var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        submitButton.addTarget(self, action: #selector(tappedSubmit), for: .touchUpInside)
        // Add subviews to view
        view.addSubview(logoView)
        view.addSubview(statusText)
        view.addSubview(emailField)
        view.addSubview(submitButton)
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        view.frame = view.bounds
        
        logoView.frame = CGRect(x: (view.width - size) / 2,
                                y: 10,
                                width: size,
                                height: size)
        
        statusText.frame = CGRect(x: (view.width - size) / 2,
                                  y: 290,
                                  width: size,
                                  height: size)
        
        
        emailField.frame = CGRect(x: (view.width - size) / 2,
                                  y: 350,
                                  width: size,
                                  height: 50)
        
        submitButton.frame = CGRect(x: 120,
                                    y: 415,
                                    width: size / 2,
                                    height: 50)
    }
    
    // TODO
    @objc private func tappedSubmit() {
        let email = emailField.text!
        Task {
            let attempt = try await userAuth.forgotPasswordEmail(email: email)
            if attempt {
                statusText.text = "Email sent! Check your inbox for email"
            } else {
                statusText.text = "Provided email was not found. \nPlease Try Again"
                print("Could not send email to \(email)")
            }
            
        }
            

    }
    
    
}

#Preview {
    ForgotPasswordViewController()
}

