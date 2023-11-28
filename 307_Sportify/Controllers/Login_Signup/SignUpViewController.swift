//
//  SignUpViewController.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/21/23.
//

import UIKit
import SwiftUI

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @State var userAuth = UserAuthentication()
    @State var isPrivate = false
    let sportList = Sport.sportData()
    var selectedSport: Int?
    var pictureSelected = false
    
    // Might be too long to fit, use a scroll view
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
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
    
    // Profile picture
    var picView: UIImageView = {
        let picView = UIImageView()
        picView.image = UIImage(systemName: "person.circle")
        picView.tintColor = .sportGold
        picView.contentMode = .scaleAspectFit
        picView.layer.masksToBounds = true
        picView.layer.borderWidth = 0.5
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
        field.isSecureTextEntry = false
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
    
    // Sports label
    private let sportsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sport preference:"
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
    
    private var revealButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        return button
    }()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent compontnt: Int) -> Int {
        return sportList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = sportList[row].name
        return item
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: sportList[row].name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.sportGold])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSport = row
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "", size: 1)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = sportList[row].name
        pickerLabel?.textColor = .sportGold

        return pickerLabel!
    }

    
    // Sign up button
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("SIGN UP", for: .normal)
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
        
        // Functionality for the buttons
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        signupButton.addTarget(self, action: #selector(tappedSignup), for: .touchUpInside)
        
        revealButton.addTarget(self, action: #selector(revealButtonTapped), for: .touchUpInside)
        
        picView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(profilePicTapped))
        picView.addGestureRecognizer(tap)
        
        // Add subviews to view
        view.addSubview(scrollView)
        scrollView.addSubview(backButton)
        scrollView.addSubview(picView)
        scrollView.addSubview(editPicPrompt)
        scrollView.addSubview(emailField)
        scrollView.addSubview(nameField)
        scrollView.addSubview(signupButton)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(zipcodeField)
        scrollView.addSubview(isPrivateSlider)
        scrollView.addSubview(privateLabel)
        scrollView.addSubview(revealButton)
        
        scrollView.addSubview(sportsLabel)
        sportPicker.delegate = self as UIPickerViewDelegate
        sportPicker.dataSource = self as UIPickerViewDataSource
        scrollView.addSubview(sportPicker)
        sportPicker.center = self.view.center
    }
    
    
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width / 1.3
        backButton.frame = CGRect(x: 15,
                                  y: 20,
                                  width: 70,
                                  height: 30)
        picView.frame = CGRect(x: 120,
                               y: 100,
                               width: scrollView.width/2.5,
                               height: scrollView.width/2.5)
        picView.layer.cornerRadius = picView.width / 2
        editPicPrompt.frame = CGRect(x: (view.width - size) / 2,
                                     y: picView.bottom - 3,
                                     width: size,
                                     height: 25)
        emailField.frame = CGRect(x: 45,
                                  y: editPicPrompt.bottom + 20,
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
                                    y: zipcodeField.bottom + 8,
                                    width: size,
                                    height: 50)
        isPrivateSlider.frame = CGRect(x:298,
                                       y: zipcodeField.bottom + 15,
                                       width: 1,
                                       height: 1)
        sportsLabel.frame = CGRect(x: 50,
                                   y: privateLabel.bottom,
                                   width: size,
                                   height: 50)
        sportPicker.frame = CGRect(x: 220,
                                   y: privateLabel.bottom - 25,
                                   width: 165,
                                   height: 100)
        signupButton.frame = CGRect(x: 90,
                                    y: sportPicker.bottom + 15,
                                    width: 225,
                                    height: 50)
        revealButton.frame = CGRect(x: 0,
                                    y: nameField.bottom + 15,
                                    width: 50,
                                    height: 50)
    }
    
    // Back button clicked
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // reveal password
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
    
    // Sign up button clicked
    @objc private func tappedSignup() {
        guard let email = emailField.text, let password = passwordField.text, let fullName = nameField.text, let zipCode = zipcodeField.text,
              !email.isEmpty, !password.isEmpty,!zipCode.isEmpty, !fullName.isEmpty else {
            // Show alert popup
            let alertController = UIAlertController(title: "Fields Incomplete", message: "Please fill out all the fields to create an account.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
            print("email is empty, password is empty")
            return
        }
        Task {
            if try await userAuth.createUser(withEmail: email, password: password, fullname: fullName, privateAccount: isPrivateSlider.isOn, zipCode: zipCode, sport: selectedSport ?? 0) {
                print("new user created")
                
                if pictureSelected == true {
                    guard let image = self.picView.image, let data = image.pngData() else {
                        return
                    }
                    
                    var safeEmail: String {
                        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
                        safeEmail = email.replacingOccurrences(of: "@", with: "-")
                        return safeEmail
                    }
                    let fileName = "\(safeEmail)_profile_picture.png"
                    
                    // upload picture
                    assert(fileName != "")
                    StorageManager.shared.uploadProfilePic(with: data, fileName: fileName, completion: { result in
                        switch result {
                        case.success(let message):
                            print(message)
                        case.failure(let error):
                            print("storage manager error: \(error)")
                        }
                    })
                }
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
                   UIApplication.shared.windows.first?.rootViewController = tabBarController
                   UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        }
    }
    
    // Upload Profile Picture clicked
    @objc private func profilePicTapped() {
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

#Preview {
    SignUpViewController()
}
