//
//  InputLocationSearchField.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/19/26.
//

import SwiftUI
import MapKit

struct InputLocationSearchField: View {
    @Binding var text: String
    let fieldTitle: String
    let fieldImage: String
    let fieldContent: String
    let iconColor: Color
    let completions: [SearchCompletions]
    let onSubmitAction: () -> ()
    let onChangeAction: () -> ()
    
    @State private var selectedCompletion: Bool = false
    
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
                
                TextField(text: $text) {
                    Text(fieldContent)
                }
                .foregroundStyle(.primary)
                .onSubmit {
                    onSubmitAction()
                    selectedCompletion = false
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(
                        Color.secondaryText.opacity(0.2),
                        style: StrokeStyle(lineWidth: 1)
                    )
            )
            .overlay(alignment: .top, content: {
                VStack {
                    if !completions.isEmpty {
                        VStack(alignment: .leading) {
                            ForEach(
                                completions.prefix(4)
                            ) { completion in
                                Button {
                                    text = completion.title + ", " + completion.subTitle
                                    selectedCompletion = true
                                } label: {
                                    VStack(alignment: .leading) {
                                        Text(completion.title)
                                            .font(
                                                .system(
                                                    size: 14,
                                                    weight: .semibold
                                                )
                                            )
                                            .foregroundStyle(.black)
                                        Text(completion.subTitle)
                                            .font(.system(size: 10))
                                            .foregroundStyle(.secondaryText)
                                    }
                                    .padding(10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                        .padding()
                        .createCardBackgroud()
                        .padding(.top, 55)
                    }
                }
            })
            .onChange(of: text, { oldValue, newValue in
                if !newValue.isEmpty {
                    onChangeAction()
                }
            })
        }
    }
}

// TODO: Might need to add the search options show up for the Preview
#Preview {
    @Previewable @State var exampleText: String = ""
    
    InputLocationSearchField(text: $exampleText, fieldTitle: "password", fieldImage: "lock", fieldContent: "Enter password", iconColor: .accentPrimary, completions: []) {
        
    } onChangeAction: {
        
    }
}
