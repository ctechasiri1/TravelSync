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
    
    @State private var isButtonPressed: Bool = false
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: imageString)
                
                Text(text)
            }

        }
        .styledButton(buttonStyle: .filled, foregroundColor: .black, backgroundColor: .white) { }
        .onLongPressGesture {
            isButtonPressed.toggle()
        } onPressingChanged: { pressing in
            isButtonPressed = pressing
        }
        .scaleEffect(isButtonPressed ? 0.9 : 1.0)
        .animation(.smooth, value: isButtonPressed)
    }
}

#Preview {
    NavigationStack {
        LinkedButton(text: "Detail", imageString: "map") {
            Text("Hello")
        }
    }
}
