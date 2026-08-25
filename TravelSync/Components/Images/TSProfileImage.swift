//
//  TSProfileImage.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/24/26.
//


import PhotosUI
import SwiftUI

struct TSProfileImage: View {
    
    @Binding var profileUIImage: UIImage?
    @Binding var profileImageURL: URL?
    let height: CGFloat
    let canEditProfilePicture: Bool
    
    init(profileUIImage: Binding<UIImage?>, profileImageURL: Binding<URL?>, height: CGFloat = 200, canEditProfilePicture: Bool) {
        self._profileUIImage = profileUIImage
        self._profileImageURL = profileImageURL
        self.height = height
        self.canEditProfilePicture = canEditProfilePicture
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Group {
                if let profileImage = profileUIImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .clipShape(Circle())
                } else {
                    TSLazyImage(imageURL: profileImageURL)
                        .clipShape(Circle())
                }
            }
            .frame(height: height)
            .overlay(alignment: .bottomTrailing, content: {
                TSPhotoPicker(coverUIImage: $profileUIImage, pickerIconName: TSSystemImageName.cameraFill, pickerShape: .circle)
                    .padding()
                    .padding(.trailing, 60)
            })
        }
    }
}

#Preview("Failed Image & URL") {
    @State @Previewable var profileUIImage: UIImage? = nil
    @State @Previewable var profileUIImageURL: URL? = nil
    
    TSProfileImage(profileUIImage: $profileUIImage, profileImageURL: $profileUIImageURL, height: 200, canEditProfilePicture: true)
        .padding()
}

#Preview("Success URL") {
    @State @Previewable var profileUIImage: UIImage? = nil
    @State @Previewable var profileUIImageURL: URL? = URL(string: "https://picsum.photos/seed/picsum/200/300")!
    
    TSProfileImage(profileUIImage: $profileUIImage, profileImageURL: $profileUIImageURL, height: 200, canEditProfilePicture: false)
        .padding()
}

#Preview("Success Image") {
    @State @Previewable var profileUIImage: UIImage? = UIImage(resource: .defaultCover)
    @State @Previewable var profileUIImageURL: URL? = nil
    
    TSProfileImage(profileUIImage: $profileUIImage, profileImageURL: $profileUIImageURL, height: 200, canEditProfilePicture: true)
        .padding()
}

#Preview("Success Image & URL") {
    @State @Previewable var profileUIImage: UIImage? = UIImage(resource: .defaultCover)
    @State @Previewable var profileUIImageURL: URL? = URL(string: "https://picsum.photos/seed/picsum/200/300")!
    
    TSProfileImage(profileUIImage: $profileUIImage, profileImageURL: $profileUIImageURL, height: 200, canEditProfilePicture: false)
        .padding()
}

