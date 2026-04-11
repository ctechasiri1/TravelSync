//
//  ProfileImage.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/24/26.
//

import PhotosUI
import SwiftUI

struct ProfileImage: View {
    @Environment(AppState.self) private var appState
    @Binding var profileUIImage: UIImage?
    @State private var selectedImage: PhotosPickerItem?
    
    let canEditPhoto: Bool
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Group {
                if let profileImage = profileUIImage {
                    Image(uiImage: profileImage)
                        .resizable()
                } else {
                    Image("default_cover")
                        .resizable()
                }
            }
            .scaledToFill()
            .clipShape(Circle())
            
            if canEditPhoto {
                PhotosPicker(selection: $selectedImage) {
                    Image(systemName: "camera.fill")
                        .foregroundStyle(Color.white)
                        .background(
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color.orange, Color.accentPrimary],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                                .strokeBorder(Color.white, lineWidth: 2)
                                .frame(width: 40, height: 40)
                                .foregroundStyle(Color.accentBlue)
                        )
                        .frame(width: 30, height: 30)
                        .offset(x: -60, y: -1)
                }
            }
        }
        .onChange(of: selectedImage) {
            Task {
                if let data = try? await selectedImage?.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        profileUIImage = image
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var profileUIImage: UIImage? = nil
    
    ProfileImage(profileUIImage: $profileUIImage, canEditPhoto: true)
        .environment(AppState())
}
