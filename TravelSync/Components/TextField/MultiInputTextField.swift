//
//  MultiInputTextField.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/28/26.
//

import SwiftUI

struct MultiInputTextField: View {
    @Binding var notesContent: String?
    let fieldTitle: String
    
    var body: some View {
        VStack {
            Text(fieldTitle)
                .foregroundStyle(Color.primaryText)
                .font(.system(size: 15, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            TextField(
                "Any extra details, booking codes, or menu preferences ...",
                text: Binding(
                    get: { notesContent ?? "" },
                    set: { notesContent = $0 }),
                axis: .vertical
            )
            .lineLimit(3...10)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(
                        Color.secondaryText.opacity(0.2),
                        style: StrokeStyle(lineWidth: 1)
                    )
            )
        }
    }
}

#Preview {
    @Previewable @State var notesContent: String? = nil
    MultiInputTextField(notesContent: $notesContent, fieldTitle: "Notes")
}
