//
//  CachedAsyncImage.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/10/26.
//

import SwiftUI

// TODO: will implement the cache portion later
struct CachedAsyncImage: View {
    let imageURL: URL?
    let height: CGFloat
    
    var body: some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .frame(height: height)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 15))
        } placeholder: {
            ZStack {
                Color.gray.opacity(0.5)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                ProgressView()
                    .frame(height: height)
            }
        }
    }
}

#Preview {
    CachedAsyncImage(imageURL: nil, height: 250)
}
