//
//  SelectPicture.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/4/23.
//

import Foundation
import UIKit

class SelectPicture: UIViewController {
    
}

extension SelectPicture: UIImagePickerControllerDelegate {
    
    func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take picture",
                                            style: .default,
                                            handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose from camera roll",
                                            style: .default,
                                            handler: { _ in
            
        }))
        present(actionSheet, animated: true)
    }
    
    // Gets called when user takes or chooses a pic
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
    
    // Gets called when user cancels select pic
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
}
