//
//  SignUpViewController.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/21/23.
//

import UIKit
import SwiftUI

class SignUpViewController: UIViewController {
    
    @State var isPrivate = false
    @State var sportList = ["Tennis", "Table Tennis", "Volleyball", "Soccer", "Basketball", "Football", "Baseball", "Badminton", "Golf", "Cycling", "Running", "Hockey", "Spikeball", "Handball", "Lacrosse", "Squash"]
    
    // Might be too long to fit, use a scroll view
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
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
        return field
    }()
    
    // Name txt field
    private let nameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.placeholder = "Full Name"
        field.backgroundColor = .lightGray
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .lightGray
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
        return field
    }()
    
    // Zipcode txt field
    private let zipcodeField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.placeholder = "Zipcode"
        field.backgroundColor = .lightGray
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .lightGray
        field.isSecureTextEntry = true
        return field
    }()
    
    // Private account label
    private let privateLabel: UILabel = {
        let label = UILabel()
        label.text = "Private Account"
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    // Private account slider
    private let isPrivateSlider: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    // Update profile pic button
    private let profilePic: UIButton = {
        let button = UIButton()
        button.setTitle("Upload Profile Picture", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .black
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    // Sports label
    private let sportsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sports:"
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    // Sport picker
    private var sportPicker: UIPickerView = {
        let picker = UIPickerView()
       // picker.dataSource = sportList
        //picker.backgroundColor = .white
        return picker
    }()
    
    // Sign up button
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("SIGN UP", for: .normal)
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
        
        // Add subviews to view
        view.addSubview(scrollView)
        scrollView.addSubview(logoView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(nameField)
        scrollView.addSubview(signupButton)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(zipcodeField)
        scrollView.addSubview(isPrivateSlider)
        scrollView.addSubview(privateLabel)
        scrollView.addSubview(profilePic)
        scrollView.addSubview(sportsLabel)
        scrollView.addSubview(sportPicker)
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width / 1.3
        logoView.frame = CGRect(x: (scrollView.width - size) / 2,
                                y: 10,
                                width: size,
                                height: size)
        emailField.frame = CGRect(x: 45,
                                  y: logoView.bottom - 50,
                                  width: size,
                                  height: 50)
        nameField.frame = CGRect(x: 45,
                                 y: emailField.bottom + 15,
                                 width: size,
                                 height: 50)
        passwordField.frame = CGRect(x: 45,
                                     y: nameField.bottom + 15,
                                     width: size,
                                     height: 50)
        zipcodeField.frame = CGRect(x: 45,
                                    y: passwordField.bottom + 15,
                                    width: size,
                                    height: 50)
        privateLabel.frame = CGRect(x: 50,
                                    y: zipcodeField.bottom + 5,
                                    width: size,
                                    height: 50)
        isPrivateSlider.frame = CGRect(x:298,
                                       y: zipcodeField.bottom + 15,
                                       width: 1,
                                       height: 1)
        profilePic.frame = CGRect(x: 47,
                                  y: privateLabel.bottom - 5,
                                  width: size / 1.65,
                                  height: 30)
        sportsLabel.frame = CGRect(x: 50,
                                   y: profilePic.bottom - 3,
                                   width: size,
                                   height: 50)
        sportPicker.frame = CGRect(x:100,
                                   y: profilePic.bottom + 15,
                                   width: 50,
                                   height: 50)
        signupButton.frame = CGRect(x: 90,
                                    y: logoView.bottom + 355,
                                    width: 225,
                                    height: 50)
    }
    
    @objc private func tappedLogIn() {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

#Preview {
    SignUpViewController()
}
