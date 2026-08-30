//
//  TSInputTextField.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import SwiftUI

// TODO: I need to consider preventing emojis being types into the textfield and apply validation

enum TextFieldOption {
    case email, password, name, username
    
    var iconName: String {
        switch self {
        case .email:
            TSSystemImageName.envelope
        case .password:
            TSSystemImageName.lockFill
        case .name:
            TSSystemImageName.pencil
        case .username:
            TSSystemImageName.personFill
        }
    }
}

struct TSInputTextField: View {
    
    @Binding var inputText: String
    @State var showSecuredFieldButton: Bool
    
    let option: TextFieldOption
    let title: String
    let content: String
    
    @State private var isSecuredField: Bool = false
    
    init(inputText: Binding<String>, showSecuredFieldButton: Bool = false, option: TextFieldOption, title: String, content: String) {
        self._inputText = inputText
        self.showSecuredFieldButton = showSecuredFieldButton
        self.option = option
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .sectionTitle()
            
            HStack {
                if inputText.isEmpty {
                    Image(systemName: option.iconName)
                        .foregroundStyle(.gray)
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
            .subtleRoundedBorder()
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
    TSInputTextField(inputText: $exampleText, option: .email, title: "Email", content: "Enter email")
        .padding()
}

#Preview("Secured Button") {
    @State @Previewable var exampleText: String = ""
    
    TSInputTextField(inputText: $exampleText, showSecuredFieldButton: true, option: .password, title: "Password", content: "Enter password")
        .padding()
}
