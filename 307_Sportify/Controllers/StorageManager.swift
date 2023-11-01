//
//  StorageManager.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 11/1/23.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    public typealias uploadPicCompletion = (Result<String, Error>)
    
    public func uploadProfilePic(with data: Data, fileName: String, completion: uploadPicCompletion) {
        storage.child("profilePictures/\(fileName)").putData(data, completion: { metadata, error in
            guard error == nil else {
                // Failed
                print("failed to upload profile pic")
                return
            }
            
//            self.storage.child("profilePictures/\(fileName)").downloadURL(completion: { url, error Int
//                guard let url = url else {
//                    print("failed to get url")
//                    return
//                }
//            })
        })
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
    }
}
