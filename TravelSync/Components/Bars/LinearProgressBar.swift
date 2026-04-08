//
//  LinearProgressBar.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/3/26.
//

import SwiftUI

struct LinearProgressBar<Shape: SwiftUI.Shape>: View {
    var value: Double
    var shape: Shape

    var body: some View {
        shape.fill(.foreground.quaternary)
            .clipShape(shape)
             .overlay(alignment: .leading) {
                 GeometryReader { proxy in
                     shape.fill(.tint)
                          .frame(width: proxy.size.width * value)
                          .animation(.easeInOut(duration: 1), value: value)
                 }
             }
    }
}


#Preview {
    LinearProgressBar(value: 0.2, shape: RoundedRectangle(cornerRadius: 20))
}
