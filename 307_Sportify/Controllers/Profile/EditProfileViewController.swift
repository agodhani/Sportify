//
//  EditProfileViewController.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/28/23.
//

import UIKit
import SwiftUI
import Firebase

class EditProfileViewController: UIViewController {
    
    @State var userAuth = UserAuthentication()
    private var newUsername = ""
    private var newEmail = ""
    private var newZipcode = ""
    var pictureSelected = false
    
    // Profile picture
    var picView: UIImageView = {
        let picView = UIImageView()
        //picView.image = UIImage(systemName: "person")
        picView.tintColor = .sportGold
        picView.contentMode = .scaleAspectFit
        picView.layer.masksToBounds = true
        picView.layer.borderWidth = 2
        picView.layer.borderColor = UIColor.lightGray.cgColor
        return picView
    }()
    
    private var editPicPrompt: UITextView = {
        let text = UITextView()
        text.text = "Click icon to edit image"
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 15, weight: .light)
        text.isEditable = false
        return text
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
        view.backgroundColor = .black
//        title = "Edit Profile"
//        let appearence = UINavigationBarAppearance()
//        appearence.titleTextAttributes = [.foregroundColor: UIColor.sportGold]
//        navigationItem.standardAppearance = appearence
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonTapped))
        
        // Functionality for tapping profile pic and update profile button
        picView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(profilePicTapped))
        picView.addGestureRecognizer(tap)
        
        updateProfileButton.addTarget(self, action: #selector(updateProfileTapped), for: .touchUpInside)

        // Add subviews to view
        view.addSubview(picView)
        view.addSubview(editPicPrompt)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(zipcodeField)
        view.addSubview(updateProfileButton)
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = view.width / 1.3
        picView.frame = CGRect(x: 120,
                                     y: 100,
                                     width: view.width/2.5,
                                     height: view.width/2.5)
        picView.layer.cornerRadius = picView.width / 2
        editPicPrompt.frame = CGRect(x: (view.width - size) / 2,
                                     y: picView.bottom - 3,
                                     width: size,
                                     height: 25)
        usernameField.frame = CGRect(x: 45,
                                 y: editPicPrompt.bottom + 20,
                                 width: size,
                                 height: 50)
        emailField.frame = CGRect(x: 45,
                                 y: usernameField.bottom + 15,
                                 width: size,
                                 height: 50)
        zipcodeField.frame = CGRect(x: 45,
                                 y: emailField.bottom + 15,
                                 width: size,
                                 height: 50)
        updateProfileButton.frame = CGRect(x: 90,
                                        y: zipcodeField.bottom + 50,
                                        width: 225,
                                        height: 50)
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.dismiss(animated: true)
    }
    
    @objc func profilePicTapped() {
        presentPhotoPicker()
    }
    
    @objc private func updateProfileTapped() {
        let db = Firestore.firestore()
        let user_id = userAuth.currUser?.id
        let user_email = userAuth.currUser?.email
        let currentUser = userAuth.currUser
        
        // Update variables
        if usernameField.hasText {
            newUsername = usernameField.text!
        } else {
            newUsername = currentUser!.name
        }
        
        if emailField.hasText {
            newEmail = emailField.text!
        } else {
            newEmail = currentUser!.email
        }
        
        if zipcodeField.hasText {
            newZipcode = zipcodeField.text!
        } else {
            newZipcode = currentUser!.zipCode
        }
        
        // Update db
        db.collection("Users").document(user_id!).updateData(["name": newUsername, "email": newEmail, "zipCode": newZipcode])
        
        if (pictureSelected == true) {
            guard let image = self.picView.image, let data = image.pngData() else {
                return
            }
            
            // modify email to tie up user to their profile pic in db
            var safeEmail: String {
                var safeEmail = user_email?.replacingOccurrences(of: ".", with: "-")
                safeEmail = user_email?.replacingOccurrences(of: "@", with: "-")
                return safeEmail!
            }
            let fileName = "\(safeEmail)_profile_picture.png"
            
            // upload picture
            StorageManager.shared.uploadProfilePic(with: data, fileName: fileName, completion: { result in
                switch result {
                case.success(let message):
                    print(message)
                case.failure(let error):
                    print("storage manager error: \(error)")
                }
            })
        }
        self.navigationController?.dismiss(animated: true)
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
        pictureSelected = true
        self.picView.image = selectedImage
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
