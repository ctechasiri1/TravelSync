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
    
    var body: some View {
        @Bindable var settingsViewModel = appState.settings
        
        ZStack(alignment: .bottomTrailing) {
            settingsViewModel.displayImage
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay {
                    Circle().strokeBorder(
                        LinearGradient(
                            colors: [Color.orange, Color.accentPrimary],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 5)
                }
            
            PhotosPicker(selection: $settingsViewModel.selectedItem) {
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
                    .offset(x: -1, y: -1)
            }
        }
        .onChange(of: settingsViewModel.selectedItem) { _, newItem in
            handleImageChange(newItem, in: settingsViewModel)
        }
    }
    
    private func handleImageChange(_ item: PhotosPickerItem?, in viewModel: SettingsViewModel) {
        Task {
            if let data = try? await item?.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                viewModel.profileUIImage = uiImage
            }
        }
    }
}



#Preview {
    ProfileImage()
        .environment(AppState())
}
