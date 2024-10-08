//
//  EditProfileView.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/4/23.
//

import SwiftUI
import Firebase
import FirebaseStorage

extension Image {
    func style() -> some View {
        self.resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .clipped()
            .overlay() {
                ZStack {
                    Image(systemName: "camera.fill")
                        .foregroundColor(.gray)
                        .offset(y: 60)
                    
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(.white, lineWidth: 4)
                }
            }
    }
}
class editControl: UIViewController {
    
}

struct EditProfileView: View {
    @EnvironmentObject var userAuth: UserAuthentication
    @State private var showImagePicker: Bool = false
    @State private var inputImage: UIImage?
    @State private var profilePic: Image = Image("DefaultProfile")
    @State private var newUsername = ""
    @State private var newEmail = ""
    @State private var newLocation = ""
    @State private var profile = false
    @State private var back = false
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            print("Back button clicked")
                            back = true
                        } label: {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                    }
                }
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                       print("pic button clicked")
                    }) {
                 //       if (userAuth.currUser?.getProfilePic() == nil) {
                        profilePic
                            .style()
                            .onTapGesture {
                                showImagePicker = true
                            }
                            .onChange(of: inputImage) {loadImage()}
                            .sheet(isPresented: $showImagePicker) {
                                ImagePicker(image: $inputImage)
                            }
                
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 200, height: 200)
//                                .cornerRadius(200)
//                                .clipShape(Circle())
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
                
                TextField("New Email", text: $newEmail)
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
                    let db = Firestore.firestore()
                    let user_id = userAuth.currUser?.id
                    let currentUser = userAuth.currUser!
                    
                    let newPic = inputImage
                    let newPicData = newPic?.jpegData(compressionQuality: 0.4)
                    
                    let storageRef = Storage.storage().reference(forURL: "gs://sportify-cc497.appspot.com")
                    let storageProfilePicRef = storageRef.child("Profile Picture").child(user_id!)
                    
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/jpeg"
                    
                    var Url = ""
                    if(newPicData != nil) {
                        storageProfilePicRef.putData(newPicData ?? Data.init(), metadata: metadata, completion:
                                                        { (StorageMetadata, error) in
                            if error != nil {
                                print(error?.localizedDescription as Any)
                            }
                            
                            storageProfilePicRef.downloadURL(completion: { (url, error) in
                                if let profilePicUrl = url?.absoluteString {
                                    print(profilePicUrl)
                                    Url = profilePicUrl
                                    //TODO: update user profile pic in firebase
                                    
                                }
                            })
                        })
                    }
                    if newUsername == "" {
                        newUsername = currentUser.name
                    }
                    if newEmail == "" {
                        newEmail = currentUser.email
                    }
                    if newLocation == "" {
                        newLocation = currentUser.zipCode
                    }
                    if Url == "" {
                        Url = currentUser.profilePicture
                    }
                    db.collection("Users").document(user_id!).updateData(["name": newUsername,
                                    "email": newEmail,
                                    "zipCode": newLocation,
                                    "profilePicture": Url])
                    //currentUser?.updateEmail(to: newEmail)
                    var user = userAuth.currUser
                    user?.name = newUsername
                    user?.zipCode = newLocation
                }
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .frame(width: 225, height: 50)
                .background(Color("SportGold"))
                .cornerRadius(200)
                .offset(CGSize(width: 0, height: 100))
            }
            if(profile || back) {
               // EditProfileView.hidden(self)
                ProfileView()
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {return}
        profilePic = Image(uiImage: inputImage)
    }
}

#Preview {
    EditProfileView()
}
