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
    
    public typealias uploadPicCompletion = (Result<String, Error>) -> Void
    
    public func uploadProfilePic(with data: Data, fileName: String, completion: @escaping uploadPicCompletion) {
        storage.child("profilePictures/\(fileName)").putData(data, metadata: nil, completion: { metadata, error in
            guard error == nil else {
                // Failed
                print("failed to upload profile pic")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self.storage.child("profilePictures/\(fileName)").downloadURL(completion: { url, error in
                guard let url = url else {
                    print("failed to get url")
                    completion(.failure(StorageErrors.filedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("url returned: \(urlString)")
                completion(.success(urlString))
            })
        })
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
        case filedToGetDownloadUrl
    }
}
