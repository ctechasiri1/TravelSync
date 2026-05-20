//
//  LocationSearchField.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/19/26.
//

import SwiftUI
import MapKit

struct LocationSearchField: View {
    @Binding var text: String
    let fieldTitle: String
    let fieldImage: String
    let fieldContent: String
    let iconColor: Color
    
    @State private var locationService = LocationSearchService(completer: .init())
    @State private var selectedCompletion: Bool = false
    
    var body: some View {
        VStack {
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
                    .textCase(.lowercase)
                    .foregroundStyle(.primary)
                    .onSubmit {
                        selectedCompletion = false
                        locationService.completions = []
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
                .overlay(
                    VStack {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(
                                Color.secondaryText.opacity(0),
                                style: StrokeStyle(lineWidth: 1)
                            )

                        if !locationService.completions.isEmpty {
                            VStack(alignment: .leading) {
                                ForEach(
                                    locationService.completions.prefix(5)
                                ) { completion in
                                    Button {
                                        text = completion.title
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
                                    }
                                }
                            }
                            .padding()
                            .createCardBackgroud()
                            .offset(y: 180)
                        }
                    }
                )
                .onChange(of: text) {
                    locationService.update(queryFragement: text)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var exampleText: String = ""
    
    LocationSearchField(text: $exampleText, fieldTitle: "password", fieldImage: "lock", fieldContent: "Enter password", iconColor: .accentPrimary)
}
