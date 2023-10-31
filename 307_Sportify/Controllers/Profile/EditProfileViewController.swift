//
//  EditProfileViewController.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/28/23.
//

import UIKit
import SwiftUI

class EditProfileViewController: UIViewController {
    
    @State var userAuth = UserAuthentication()
    
    // Profile picture
    private var picView: UIImageView = {
        let picView = UIImageView()
        picView.image = UIImage(systemName: "person")
        picView.layer.masksToBounds = true
        picView.contentMode = .scaleAspectFit
        //picView.layer.cornerRadius = picView.width / 10
        picView.layer.borderWidth = 2
        picView.layer.borderColor = UIColor.lightGray.cgColor
        return picView
    }()
    
    // New username field
    private let usernameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.placeholder = "New Username"
        field.backgroundColor = .lightGray
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .lightGray
        field.isSecureTextEntry = true
        field.tintColor = .black
        return field
    }()
    
    // New email field
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.placeholder = "New Email"
        field.backgroundColor = .lightGray
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .lightGray
        field.isSecureTextEntry = true
        field.tintColor = .black
        return field
    }()
    
    // New location field
    private let zipcodeField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.placeholder = "New Zipcode"
        field.backgroundColor = .lightGray
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .lightGray
        field.isSecureTextEntry = true
        field.tintColor = .black
        return field
    }()
    
    // IF TIME ALLOWS: New sports preferences picker
    
    // Update profile button
    private let updateProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update Profile", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Functionality for tapping profile pic and update profile button
        picView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(profilePicTapped))
        picView.addGestureRecognizer(tap)
        
        updateProfileButton.addTarget(self, action: #selector(updateProfileTapped), for: .touchUpInside)

        // Add subviews to view
        view.addSubview(picView)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(zipcodeField)
        view.addSubview(updateProfileButton)
    }
    
    @objc func profilePicTapped() {
        
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = view.width / 1.3
        picView.frame = CGRect(x: 120,
                                     y: 70,
                                     width: view.width/2.5,
                                     height: view.width/2.5)
    }
    
    @objc private func updateProfileTapped() {
        
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

#Preview() {
    EditProfileViewController()
}
