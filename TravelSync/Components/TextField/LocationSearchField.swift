//
//  LocationSearchField.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/18/26.
//

import MapKit
import SwiftUI

struct LocationSearchField: View {
    @Binding var text: String
    let fieldTitle: String
    let fieldImage: String
    let fieldContent: String
    let iconColor: Color
    var characterLimit: Int? = nil
    
    @State private var manager: LocationSearchManager
    @State private var debounceTask: Task<Void, Never>?
    
    init(
        text: Binding<String>,
        fieldTitle: String,
        fieldImage: String,
        fieldContent: String,
        iconColor: Color,
        scope: LocationSearchScope = .citiesAndCountries,
        characterLimit: Int? = nil
    ) {
        _text = text
        self.fieldTitle = fieldTitle
        self.fieldImage = fieldImage
        self.fieldContent = fieldContent
        self.iconColor = iconColor
        self.characterLimit = characterLimit
        _manager = State(initialValue: LocationSearchManager(scope: scope))
    }
    
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
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(
                            Color.secondaryText.opacity(0.2),
                            style: StrokeStyle(lineWidth: 1)
                        )
                )
                .onChange(of: text) { _, newValue in
                    debounceTask?.cancel()
                    debounceTask = Task {
                        try? await Task.sleep(for: .milliseconds(1000))
                        guard !Task.isCancelled else {
                            return
                        }
                        manager.updateQuery(newValue)
                    }
                }
            }
            
            if !manager.suggestions.isEmpty {
                VStack {
                    ForEach(manager.suggestions.prefix(5), id: \.self) { suggestion in
                        Button {
                            text = suggestion.title
                            Task { await manager.selectSuggestion(suggestion) }
                        } label: {
                            HStack(spacing: 12) {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundStyle(.red)
                                    .font(.title3)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(suggestion.title)
                                        .font(.subheadline)
                                        .foregroundStyle(.primary)
                                    
                                    if !suggestion.subtitle.isEmpty {
                                        Text(suggestion.subtitle)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        Divider()
                            .padding(.leading, 48)
                    }
                }
                .background(.background)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
    //            .padding(.top, 4)
            }
        }
    }
}

#Preview {
    @Previewable @State var exampleText: String = ""
    
    LocationSearchField(text: $exampleText, fieldTitle: "password", fieldImage: "lock", fieldContent: "Enter password", iconColor: .accentPrimary, scope: .citiesAndCountries)
}
