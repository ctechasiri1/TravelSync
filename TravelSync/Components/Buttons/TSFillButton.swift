//
//  TSFillButton.swift.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//

import SwiftUI

struct TSFillButton: View {
    
    let title: String
    let imageString: String?
    let foregroundColor: Color
    let backgroundColor: Color
    let isLoading: Bool?
    let action: () -> Void
    
    init(title: String, imageString: String? = nil, foregroundColor: Color = .white, backgroundColor: Color = .accentPrimary, isLoading: Bool? = nil, action: @escaping () -> Void) {
        self.title = title
        self.imageString = imageString
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.isLoading = isLoading
        self.action = action
    }

    var body: some View {
        HStack {
            if let loading = isLoading, loading == true {
                ProgressView()
                    .tint(.white)
            } else {
                if let imageName =  imageString {
                    Image(systemName: imageName)
                }
                Text(title)
            }
        }
        .styledButton(buttonStyle: .filled, foregroundColor: foregroundColor, backgroundColor: backgroundColor) {
            action()
        }
    }
}

#Preview("Login Button") {
    TSFillButton(
        title: "Login",
        imageString: nil,
        foregroundColor: .white,
        backgroundColor: .accentPrimary,
        isLoading: true) { }
}
