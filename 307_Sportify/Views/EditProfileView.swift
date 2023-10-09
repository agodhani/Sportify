//
//  EditProfileView.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/4/23.
//

import SwiftUI

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ObservableObject {
    @EnvironmentObject var userAuth: UserAuthentication
    
    let profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.image = UIImage(named:"DefaultProfile")
        profileImage.contentMode = .scaleAspectFit
        return profileImage
    }()
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Choose from camera Roll",
                                            style: .default,
                                            handler: { [weak self] _ in
                                            self?.presentPhotoPicker()
        }))
        actionSheet.addAction(UIAlertAction(title: "Take picture",
                                            style: .default,
                                            handler: { [weak self] _ in
                                            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

struct EditProfileView: View {
    @StateObject var controller = EditProfileViewController()
    @EnvironmentObject var userAuth: UserAuthentication
    @State private var newUsername = ""
    @State private var newPassword = ""
    @State private var newLocation = ""
    @State private var profile = false
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                       print("pic clicked")
                    }) {
                 //       if (userAuth.currUser?.getProfilePic() == nil) {
                            Image(uiImage: controller.profileImage.image!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                                .cornerRadius(200)
                                .clipShape(Circle())
//                        } else {
//                            Image(uiImage: (userAuth.currUser?.getProfilePic())!)
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 200, height: 200)
//                                .cornerRadius(200)
//                                .clipShape(Circle())
//                        }
                    }
                    Spacer()
                }
                //Spacer()
                TextField("New Username", text: $newUsername)
                   // .textFieldStyle(.roundedBorder)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                    .offset(CGSize(width: 0, height: 50))
                
                TextField("New Password", text: $newPassword)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                    .offset(CGSize(width: 0, height: 50))
                
                TextField("New Location", text: $newLocation)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                    .offset(CGSize(width: 0, height: 50))
                
                Button("Update Profile") {
                    profile = true
                }
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .frame(width: 225, height: 50)
                .background(Color("SportGold"))
                .cornerRadius(200)
                .offset(CGSize(width: 0, height: 100))
            }
            if(profile) {
                ProfileView()
            }
        }
    }
}

#Preview {
    EditProfileView()
}
