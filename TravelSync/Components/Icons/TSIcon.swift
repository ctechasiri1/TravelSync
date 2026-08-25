//
//  SquareIcon.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/20/26.
//

import SwiftUI

enum IconShapeOption {
    case circle, square
}

struct TSIcon: View {
    let iconShape: IconShapeOption
    let iconName: String
    let iconColor: Color
    
    init(iconShape: IconShapeOption, iconName: String, iconColor: Color) {
        self.iconShape = iconShape
        self.iconName = iconName
        self.iconColor = iconColor
    }
    
    var body: some View {
        Image(systemName: iconName)
            .bold()
            .foregroundStyle(iconColor)
            .frame(width: 40, height: 40)
            .background(
                Group {
                    switch iconShape {
                    case .circle:
                        Circle()
                            .fill(iconColor.opacity(0.1))
                    case .square:
                        RoundedRectangle(cornerRadius: 10)
                            .fill(iconColor.opacity(0.1))
                        
                    }
                }
            )
    }
}

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
                    .frame(width: width, height: height)
            )
    }
}

#Preview("Icon Designs") {
    VStack {
        TSIcon(iconShape: .square, iconName: "airplane.departure", iconColor: .accentBlue)
        TSIcon(iconShape: .circle, iconName: "airplane.departure", iconColor: .accentBlue)
    }
}

