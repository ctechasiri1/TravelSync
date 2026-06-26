//
//  FillButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//

import SwiftUI

struct FillButton: View {
    let text: String
    let imageString: String?
    let foregroundColor: Color
    let backgroundColor: Color
    let isLoading: Bool?
    let action: () -> Void
    
    init(
        text: String,
        imageString: String? = nil,
        foregroundColor: Color = .white,
        backgroundColor: Color = .accentPrimary,
        isLoading: Bool? = nil,
        action: @escaping () -> Void
    ) {
        self.text = text
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
                
                Text(text)
            }
        }
        .styledButton(buttonStyle: .filled, foregroundColor: foregroundColor, backgroundColor: backgroundColor) {
            action()
        }
    }
}

#Preview {
    FillButton(
        text: "Login",
        imageString: nil,
        foregroundColor: .white,
        backgroundColor: .accentPrimary,
        isLoading: true) { }
}
