//
//  CoverImage.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/4/26.
//

import PhotosUI
import SwiftUI

struct CoverImage: View {
    @Environment(AppState.self) private var appState
    @Binding var coverUIImage: UIImage?
    @State private var selectedImage: PhotosPickerItem?
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Group {
                if let coverImage = coverUIImage {
                    Image(uiImage: coverImage)
                        .resizable()
                } else {
                    Image("default_cover")
                        .resizable()
                }
            }
            .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 250)
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            PhotosPicker(selection: $selectedImage) {
                HStack {
                    Image(systemName: "camera.fill")
                    
                    Text("Edit Cover")
                        .font(.system(size: 15, weight: .bold))
                }
                    .foregroundStyle(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(.white.opacity(0.3))
                            .strokeBorder(Color.white, lineWidth: 1)
                            .frame(width: 150, height: 40)
                            .foregroundStyle(Color.accentBlue)
                    )
            }
            .offset(x: -40, y: -25)
        }
        .onChange(of: selectedImage) {
            Task {
                if let data = try? await selectedImage?.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        coverUIImage = image
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var coverUIImage: UIImage? = nil
    
    CoverImage(coverUIImage: $coverUIImage)
        .environment(AppState())
}
