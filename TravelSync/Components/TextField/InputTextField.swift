//
//  InputTextField.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import SwiftUI

struct InputTextField: View {
    @Binding var text: String
    @State var isSecureField: Bool = false
    @State var toggleSecurityButton: Bool = false
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
                if text.isEmpty {
                    Image(systemName: fieldImage)
                        .foregroundStyle(iconColor)
                }
                
                Group {
                    if isSecureField {
                        SecureField(text: $text) {
                            Text(fieldContent)
                        }
                    } else {
                        TextField(text: $text) {
                            Text(fieldContent)
                        }
                    }
                }
                .foregroundStyle(.primary)
                
                if toggleSecurityButton {
                    Button {
                        isSecureField.toggle()
                    } label: {
                        Image(systemName: isSecureField ? "eye" : "eye.slash")
                            .foregroundStyle(.secondaryText)
                    }
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        Color.secondaryText.opacity(0.2),
                        style: StrokeStyle(lineWidth: 1)
                    )
            )
        }
    }
}

//#Preview {
//    InputTextField(text: <#Binding<String>#>, fieldTitle: <#String#>, fieldImage: <#String#>, fieldContent: <#String#>)
//}
