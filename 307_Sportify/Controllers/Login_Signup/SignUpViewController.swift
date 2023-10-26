//
//  SignUpViewController.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/21/23.
//

import UIKit
import SwiftUI

class SignUpViewController: UIViewController {
    @State var userAuth = UserAuthentication()
    @State var isPrivate = false
    @State var sportList = ["Tennis", "Table Tennis", "Volleyball", "Soccer", "Basketball", "Football", "Baseball", "Badminton", "Golf", "Cycling", "Running", "Hockey", "Spikeball", "Handball", "Lacrosse", "Squash"]
    
    // Might be too long to fit, use a scroll view
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    // Logo
    private var logoView: UIImageView = {
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
        field.tintColor = .black
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
    private let profilePicButton: UIButton = {
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
        view.backgroundColor = .white
        
        // Back button
        let backButton = UIBarButtonItem(title: "Back",
                                         style: .done,
                                         target: self,
                                         action:
                                          #selector(backButtonTapped))
        backButton.tintColor = .sportGold
        navigationItem.backBarButtonItem = backButton
        
        
        signupButton.addTarget(self, action: #selector(tappedSignup), for: .touchUpInside)
        
        profilePicButton.addTarget(self, action: #selector(tappedProfilePic), for: .touchUpInside)
        
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
        scrollView.addSubview(profilePicButton)
        scrollView.addSubview(sportsLabel)
        scrollView.addSubview(sportPicker)
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width / 1.3
        logoView.frame = CGRect(x: (scrollView.width - size) / 2 - 3,
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
        profilePicButton.frame = CGRect(x: 47,
                                  y: privateLabel.bottom - 5,
                                  width: size / 1.65,
                                  height: 30)
        sportsLabel.frame = CGRect(x: 50,
                                   y: profilePicButton.bottom - 3,
                                   width: size,
                                   height: 50)
        sportPicker.frame = CGRect(x:100,
                                   y: profilePicButton.bottom + 15,
                                   width: 50,
                                   height: 50)
        signupButton.frame = CGRect(x: 90,
                                    y: logoView.bottom + 355,
                                    width: 225,
                                    height: 50)
    }
    
    // Back button clicked
    @objc private func backButtonTapped() {
        let vc = LoginSignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Sign in button clicked
    @objc private func tappedSignup() {
        guard let email = emailField.text, let password = passwordField.text, let fullName = nameField.text, let zipCode = zipcodeField.text,
              !email.isEmpty, !password.isEmpty,!zipCode.isEmpty, !fullName.isEmpty else {
            print("email is empty, password is empty")
                  return
              }
        Task {
            if try await userAuth.createUser(withEmail: email, password: password, fullname: fullName, privateAccount: isPrivateSlider.isOn, zipCode: zipCode, sport: 0) {
                print("new user created")
            }
        }
        //let vc =
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    // Upload Profile Picture clicked
    @objc private func tappedProfilePic() {
        presentPhotoPicker()
    }
    
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        let size = scrollView.width / 3
        
        self.logoView.image = selectedImage
        self.logoView.layer.masksToBounds = true
        logoView.contentMode = .scaleAspectFit

        self.logoView.layer.cornerRadius = logoView.width / 4
        self.logoView.layer.borderWidth = 2
        self.logoView.layer.borderColor = UIColor.lightGray.cgColor
        self.logoView.frame = CGRect(x: 120,
                                     y: 70,
                                     width: scrollView.width/2.5,
                                     height: scrollView.width/2.5)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

#Preview {
    SignUpViewController()
}
