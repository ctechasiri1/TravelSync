//
//  CoverImage.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/4/26.
//

import PhotosUI
import SwiftUI

struct TSCoverImage: View {
    
    @Binding var coverUIImage: UIImage?
    @Binding var coverUIImageURL: URL?
    let height: CGFloat
    
    init(coverUIImage: Binding<UIImage?>, coverUIImageURL: Binding<URL?>, height: CGFloat = 200) {
        self._coverUIImage = coverUIImage
        self._coverUIImageURL = coverUIImageURL
        self.height = height
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Group {
                if let coverImage = coverUIImage {
                    Image(uiImage: coverImage)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } else {
                    TSLazyImage(imageURL: coverUIImageURL)
                }
            }
            .frame(height: height)
            
            TSPhotoPicker(coverUIImage: $coverUIImage, pickerIconName: TSSystemImageName.cameraFill, pickerTitle: "Select Photo" , pickerShape: .pill)
                .padding()
        }
    }
}

#Preview("Failed Image & URL") {
    @State @Previewable var coverUIImage: UIImage? = nil
    @State @Previewable var coverUIImageURL: URL? = nil
    
    TSCoverImage(coverUIImage: $coverUIImage, coverUIImageURL: $coverUIImageURL, height: 200)
        .padding()
}

#Preview("Success URL") {
    @State @Previewable var coverUIImage: UIImage? = nil
    @State @Previewable var coverUIImageURL: URL? = URL(string: "https://picsum.photos/seed/picsum/200/300")!
    
    TSCoverImage(coverUIImage: $coverUIImage, coverUIImageURL: $coverUIImageURL, height: 200)
        .padding()
}

#Preview("Success Image") {
    @State @Previewable var coverUIImage: UIImage? = UIImage(resource: .defaultCover)
    @State @Previewable var coverUIImageURL: URL? = nil
    
    TSCoverImage(coverUIImage: $coverUIImage, coverUIImageURL: $coverUIImageURL, height: 200)
        .padding()
}

#Preview("Success Image & URL") {
    @State @Previewable var coverUIImage: UIImage? = UIImage(resource: .defaultCover)
    @State @Previewable var coverUIImageURL: URL? = URL(string: "https://picsum.photos/seed/picsum/200/300")!
    
    TSCoverImage(coverUIImage: $coverUIImage, coverUIImageURL: $coverUIImageURL, height: 200)
        .padding()
}
