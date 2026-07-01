//
//  LinkedButton.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/25/26.
//

import SwiftUI

struct LinkedButton<Destination: View>: View {
    
    let text: String
    let imageString: String
    @ViewBuilder var destination: () -> Destination
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: imageString)
                
                Text(text)
            }

        }
        .styledButton(buttonStyle: .filled, foregroundColor: .black, backgroundColor: .white) { }
        .pressEffect(isPressed: $isPressed)
    }
}

#Preview {
    NavigationStack {
        LinkedButton(text: "Detail", imageString: "map") {
            Text("Hello")
        }
    }
}
