//
//  TSLazyImage.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/10/26.
//

import Nuke
import NukeUI
import SwiftUI

struct TSLazyImage: View {
    
    let imageURL: URL?
    
    var body: some View {
        GeometryReader { geometry in
            LazyImage(url: imageURL) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if state.error != nil {
                    Color.gray.opacity(0.3)
                        .overlay {
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundStyle(.secondaryText.opacity(0.6))
                        }
                } else {
                    Color.gray.opacity(0.3)
                        .overlay {
                            ProgressView()
                        }
                }
            }
            .processors([.resize(size: geometry.size)])
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview("Failed Image") {
    TSLazyImage(imageURL: nil)
        .frame(height: 200)
        .padding()
}

#Preview("Successful Image") {
    let url = URL(string: "https://picsum.photos/300/300")!
    
    TSLazyImage(imageURL: url)
        .frame(height: 200)
        .padding()
}
