//
//  TSInputTextField.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import SwiftUI

// TODO: I need to consider preventing emojis being types into the textfield

struct TSInputTextField: View {
    
    @Binding var inputText: String
    @State var showSecuredFieldButton: Bool
    
    let title: String
    let iconName: String
    let content: String
    let iconColor: Color
    
    @State private var isSecuredField: Bool = false
    
    init(inputText: Binding<String>, showSecuredFieldButton: Bool = false, title: String, iconName: String, content: String, iconColor: Color) {
        self._inputText = inputText
        self.showSecuredFieldButton = showSecuredFieldButton
        self.title = title
        self.iconName = iconName
        self.content = content
        self.iconColor = iconColor
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .sectionTitle()
            
            HStack {
                if inputText.isEmpty {
                    Image(systemName: iconName)
                        .foregroundStyle(iconColor)
                }
                
                Group {
                    if isSecuredField {
                        SecureField(text: $inputText) {
                            Text(content)
                        }
                    } else {
                        TextField(text: $inputText) {
                            Text(content)
                        }
                    }
                }
                .foregroundStyle(.primary)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                
                if showSecuredFieldButton {
                    Button {
                        isSecuredField.toggle()
                    } label: {
                        Image(systemName: isSecuredField ? TSSystemImageName.eye : TSSystemImageName.eyeSlash)
                    }
                    .foregroundStyle(.secondaryText)
                }

            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(
                        Color.secondaryText.opacity(0.2),
                        style: StrokeStyle(lineWidth: 1)
                    )
            }
        }
        .onChange(of: inputText) { oldText, newText in
            if newText.count > 50 {
                inputText = String(newText.prefix(50))
            }
        }
    }
}

#Preview("No Secured Button") {
    @State @Previewable var exampleText: String = ""
    
    TSInputTextField(inputText: $exampleText, showSecuredFieldButton: false, title: "Password", iconName: TSSystemImageName.lockFill, content: "Enter password", iconColor: .accentPrimary)
        .padding()
}

#Preview("Secured Button") {
    @State @Previewable var exampleText: String = ""
    
    TSInputTextField(inputText: $exampleText, showSecuredFieldButton: true, title: "Password", iconName: TSSystemImageName.lockFill, content: "Enter password", iconColor: .accentPrimary)
        .padding()
}
