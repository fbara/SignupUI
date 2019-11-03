//
//  ImagePicker.swift
//  SignupUI
//
//  Created by Frank Bara on 11/2/19.
//  Copyright © 2019 BaraLabs. All rights reserved.
//

import SwiftUI
import Combine

class ImagePicker: ObservableObject {
    static let shared: ImagePicker = ImagePicker()
    private init() {}
    
    let view = ImagePicker.View()
    let coordinator = ImagePicker.Coordinator()
    
    let objectWillChange = PassthroughSubject<Image?, Never>()
    @Published var image: Image? = nil {
        didSet {
            if image != nil {
                objectWillChange.send(image)
            }
        }
    }
}

extension ImagePicker {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            ImagePicker.shared.image = Image(uiImage: image)
            picker.dismiss(animated: true)
        }
    }
}

extension ImagePicker {
    struct View: UIViewControllerRepresentable {
        
        func makeCoordinator() -> Coordinator {
            return ImagePicker.shared.coordinator
        }
        
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker.View>) -> UIImagePickerController {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = context.coordinator
            
            return imagePickerController
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker.View>) {
            
        }
        
    }
}
