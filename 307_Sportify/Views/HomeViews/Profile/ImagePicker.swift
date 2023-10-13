//
//  imagePicker.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/9/23.
//

import SwiftUI
import PhotosUI

// Wrap a UIViewControllerRepresentable
struct ImagePicker: UIViewControllerRepresentable {
    // Binding used to return selected image
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    // Coordinator to pull the sequence of events together
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated:true)
            
            guard let provider = results.first?.itemProvider else {return}
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) {image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}
