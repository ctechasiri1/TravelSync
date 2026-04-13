//
//  InputNumberField.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/12/26.
//

import SwiftUI

struct InputNumberField: View {
    @Binding var currency: Int?
    let fieldTitle: String
    let fieldImage: String
    let fieldContent: String
    let iconColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(fieldTitle)
                .foregroundStyle(Color.primaryText)
                .font(.system(size: 15, weight: .semibold))
                .padding(.leading, 5)
            
            HStack {
                if currency == nil {
                    Image(systemName: fieldImage)
                        .foregroundStyle(iconColor)
                }
                
                TextField(fieldContent, value: $currency, format: .number)
                    .foregroundStyle(.primary)
            }
            .padding()
            .overlay(
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
    @Previewable @State var exampleNumber: Int? = 0
    
    InputNumberField(
        currency: $exampleNumber,
        fieldTitle: "BUDGET",
        fieldImage: "banknote.fill",
        fieldContent: "e.g. 10,000",
        iconColor: .secondaryText
    )
}
