//
//  TSLinkedButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/25/26.
//

import SwiftUI

struct TSLinkedButton<Destination: View>: View {
    
    let title: String
    let imageString: String
    @ViewBuilder var destination: () -> Destination
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        // TODO: Add navigation destination and use a router to navigate here
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: imageString)
                
                Text(title)
            }
        }
        .styledButton(buttonStyle: .filled, foregroundColor: .black, backgroundColor: .white) { }
        .pressEffect(isPressed: $isPressed)
    }
}

#Preview("Detail Button") {
    NavigationStack {
        TSLinkedButton(title: "Detail", imageString: "map") {
            Text("Hello")
        }
    }
}
