//
//  ProfileImage.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/24/26.
//

import PhotosUI
import SwiftUI

struct ProfileImage: View {
    let imageURL: String?
    let selectedImage: UIImage?
    let canEditPhoto: Bool
    let onImagePicked: ((UIImage) -> Void)?
    
    @State private var selectedItem: PhotosPickerItem?
    
    init(
        imageURL: String?,
        selectedImage: UIImage?,
        canEditPhoto: Bool = false,
        onImagePicked: ((UIImage) -> Void)? = nil
    ) {
        self.imageURL = imageURL
        self.selectedImage = selectedImage
        self.canEditPhoto = canEditPhoto
        self.onImagePicked = onImagePicked
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Group {
                if let profileImage = selectedImage {
                    Image(uiImage: profileImage)
                        .resizable()
                } else if let urlString = imageURL {
                    AsyncImage(url: URL(string: urlString)) { image in
                        image
                            .resizable()
                    } placeholder: {
                        ZStack {
                            Color.gray.opacity(0.5)
                                .clipShape(Circle())
                            
                            ProgressView()
                                .padding()
                        }
                    }
                } else {
                    Color.gray.opacity(0.3)
                }
            }
            .scaledToFit()
            .clipShape(Circle())
            .overlay(alignment: .bottomTrailing) {
                if canEditPhoto {
                    PhotosPicker(selection: $selectedItem) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.white)
                            .frame(width: 30, height: 30)
                            .background(
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.orange, Color.accentPrimary],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ))
                                    .strokeBorder(.white, lineWidth: 2)
                            )
                    }
                }
            }
        }
        .onChange(of: selectedItem) {
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        onImagePicked?(image)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileImage(imageURL: nil, selectedImage: nil, canEditPhoto: true, onImagePicked: nil)
}
