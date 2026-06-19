//
//  SquareIcon.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/20/26.
//

import SwiftUI

struct SquareIcon: View {
    let iconName: String
    let iconColor: Color
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Image(systemName: iconName)
            .frame(width: 20, height: 20)
            .bold()
            .foregroundStyle(iconColor)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(iconColor.opacity(0.1))
                    .frame(width: width, height: height)
            )
    }
}

#Preview {
    SquareIcon(iconName: "airplane.departure", iconColor: Color.accentConfirmation, width: 50, height: 50)
}
