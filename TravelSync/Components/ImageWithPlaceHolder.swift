//
//  ImageWithPlaceHolder.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/1/26.
//

import SwiftUI

struct ImageWithPlaceHolder: View {
    let urlString: String
    let imageHeight: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { image in
            image.resizable()
        } placeholder: {
            Color.backgroundColor.tertiaryBackground
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: imageHeight)
        .ignoresSafeArea()
    }
}

#Preview {
    ImageWithPlaceHolder(urlString: "https://example.com/image.png", imageHeight: 300)
}
