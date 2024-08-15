//
//  AvatarPicker.swift
//  TGTR
//
//  Created by Elin.Andersson on 2024-08-15.
//

import Foundation
import SwiftUI

struct AvatarPicker: View {
    @Binding var selectedAvatar: Image?
    @Binding var selectedImage: Image?
    @State private var showAlert = false
    
    struct AvatarItem: Identifiable {
        var id = UUID()
        var image: Image
        var imageName: String // Add a name property to identify the image
    }

    let avatars: [AvatarItem] = [
        AvatarItem(image: Image("babygirl"), imageName: "babygirl"),
        AvatarItem(image: Image("toddlergirl"), imageName: "toddlergirl"),
        AvatarItem(image: Image("babyboy"), imageName: "babyboy"),
        AvatarItem(image: Image("toddlerboy"), imageName: "toddlerboy")
    ]

    var body: some View {
        VStack {
            Text("Välj en avatar")
                .font(.title)
                .padding()

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(avatars) { avatar in
                        avatar.image
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                            .padding()
                            .onTapGesture {
                                selectedAvatar = avatar.image
                                selectedImage = nil
                                saveSelectedAvatar(imageName: avatar.imageName)
                                showAlert = true
                            }
                    }
                }
                .padding()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Done!"), message: Text("Avatar saved successfully."), dismissButton: .default(Text("OK")))
        }
    }

    private func saveSelectedAvatar(imageName: String) {
        UserDefaults.standard.set(imageName, forKey: "selectedAvatar")
        UserDefaults.standard.removeObject(forKey: "selectedImage")
    }
}

struct AvatarPicker_Previews: PreviewProvider {
    static var previews: some View {
        AvatarPicker(selectedAvatar: .constant(nil), selectedImage: .constant(nil))
    }
}
