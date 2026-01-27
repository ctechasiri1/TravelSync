//
//  CircleIcon.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/1/26.
//

import SwiftUI

struct CircleIcon: View {
    let iconName: String
    let iconColor: Color
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Image(systemName: iconName)
            .bold()
            .foregroundStyle(iconColor)
            .background(
                Circle()
                    .fill(iconColor.opacity(0.1))
                    .strokeBorder(Color.accentBlue.opacity(0.5), lineWidth: 0.2)
                    .frame(width: width, height: height)
            )
    }
}

#Preview {
    CircleIcon(iconName: "airplane.departure", iconColor: Color.accentConfirmation, width: 50, height: 50)
}
