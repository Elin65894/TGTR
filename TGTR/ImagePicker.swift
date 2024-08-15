//
//  ImagePicker.swift
//  TGTR
//
//  Created by Elin.Andersson on 2024-08-15.
//

import Foundation
import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: Image?
    @Binding var selectedAvatar: Image?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = Image(uiImage: uiImage)
                parent.selectedAvatar = nil
                saveSelectedImage(uiImage)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        private func saveSelectedImage(_ uiImage: UIImage) {
            if let imageData = uiImage.jpegData(compressionQuality: 1.0) {
                UserDefaults.standard.set(imageData, forKey: "selectedImage")
                UserDefaults.standard.removeObject(forKey: "selectedAvatar")
            }
        }
    }
}



