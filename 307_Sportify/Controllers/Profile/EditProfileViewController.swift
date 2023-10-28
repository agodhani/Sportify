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
    
    // New email field
    
    // New location field
    
    // IF TIME ALLOWS: New sports preferences picker
    
    // Update profile button
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add subviews to view
        view.addSubview(picView)
        
        picView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(profilePicTapped))
        picView.addGestureRecognizer(tap)

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
