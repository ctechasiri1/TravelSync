//
//  TSLinearProgressBar.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/3/26.
//

import SwiftUI

struct TSLinearProgressBar<Shape: SwiftUI.Shape>: View {
    
    var progressValue: Double
    var barShape: Shape
    
    var body: some View {
        barShape.fill(.foreground.quaternary)
            .clipShape(barShape)
            .overlay(alignment: .leading) {
                GeometryReader { proxy in
                    barShape.fill(.tint)
                        .frame(width: proxy.size.width * progressValue, height: 10)
                        .animation(.easeInOut(duration: 1), value: progressValue)
                }
            }
    }
}

#Preview("Pill Progress Bar") {
    TSLinearProgressBar(progressValue: 0.01, barShape: RoundedRectangle(cornerRadius: 20))
        .tint(.accentConfirmation)
        .frame(height: 15)
        .padding(.vertical)
        .padding()
}
