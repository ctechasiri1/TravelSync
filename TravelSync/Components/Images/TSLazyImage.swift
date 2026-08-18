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
    let height: CGFloat
    let width: CGFloat
    
    var body: some View {
        LazyImage(url: imageURL) { state in
            Group {
                if let image = state.image {
                    image
                        .resizable()
                } else if state.error != nil {
                    Color.gray.opacity(0.5)
                } else {
                    ZStack {
                        Color.gray.opacity(0.5)
                        
                        ProgressView()
                            .frame(height: height)
                    }
                }
            }
            .frame(width: width, height: height)
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .processors([.resize(width: width), .resize(height: height)])
    }
}

#Preview {
    TSLazyImage(imageURL: nil, height: 250, width: 250)
}
