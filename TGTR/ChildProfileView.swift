//
//  ChildProfileView.swift
//  TGTR
//
//  Created by Elin.Andersson on 2024-08-15.
//

import Foundation
import SwiftUI
import FirebaseCore
//import FirebaseFirestore
//import FirebaseMessaging

struct ChildProfileView: View {
    @Binding var selectedAvatar: Image?
    @Binding var selectedImage: Image?
    @State private var isImagePickerPresented = false
    @State private var isAvatarPickerPresented = false

    var body: some View {
        VStack {
            if let image = selectedImage {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else if let avatar = selectedAvatar {
                avatar
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .foregroundColor(.gray)
            }

            HStack {
                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    Text("Ladda upp foto")
                        .padding()
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage, selectedAvatar: $selectedAvatar)
                }

                Button(action: {
                    isAvatarPickerPresented.toggle()
                }) {
                    Text("Välj avatar")
                        .padding()
                }
                .sheet(isPresented: $isAvatarPickerPresented) {
                    AvatarPicker(selectedAvatar: $selectedAvatar, selectedImage: $selectedImage)
                }
            }
        }
        .navigationBarTitle("Barnprofil", displayMode: .inline)
        .onAppear {
            loadSelectedImageOrAvatar()
        }
    }

    private func loadSelectedImageOrAvatar() {
        if let avatarName = UserDefaults.standard.string(forKey: "selectedAvatar") {
            selectedAvatar = Image(avatarName)
        } else if let imageData = UserDefaults.standard.data(forKey: "selectedImage"), let uiImage = UIImage(data: imageData) {
            selectedImage = Image(uiImage: uiImage)
        }
    }
}

struct ChildProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ChildProfileView(selectedAvatar: .constant(nil), selectedImage: .constant(nil))
    }
}
