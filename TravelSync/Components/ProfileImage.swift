//
//  ProfileImage.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/24/26.
//

import SwiftUI

struct ProfileImage: View {
    var body: some View {
        Circle()
            .strokeBorder(LinearGradient(colors: [Color.accentBlue, Color.accentConfirmation], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 5)
            .frame(width: 100, height: 100)
            .foregroundStyle(Color.backgroundColor.tertiaryBackground)
        
            .overlay {
                Button {
                    
                } label: {
                    Image(systemName: "camera.fill")
                        .foregroundStyle(Color.white)
                        .background(
                            Circle()
                                .fill(Color.accentBlue)
                                .strokeBorder(Color.white, lineWidth: 2)
                                .frame(width: 40, height: 40)
                                .foregroundStyle(Color.accentBlue)
                        )
                        .frame(width: 30, height: 30)
                        .offset(x: 30, y: 40)
                }
            }
    }
}

#Preview {
    ProfileImage()
}
