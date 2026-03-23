//
//  PersonalInfoScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/24/26.
//

import SwiftUI

struct PersonalInfoScreen: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        @Bindable var settingsViewModel = appState.settings
        
        NavigationStack {
            ScrollView {
                ProfileImage()
                    .padding(.vertical, 50)
                
                VStack(spacing: 15) {
                    EditCard(field: $settingsViewModel.userName, cardName: "USERNAME", placeholder: "Edit Username")
                    
                    EditCard(field: $settingsViewModel.fullName, cardName: "FULL NAME", placeholder: "Edit Name")
                    
                    EditCard(field: $settingsViewModel.emailAddress, cardName: "EMAIL", placeholder: "Edit Email")
                    
                    EditCard(field: $settingsViewModel.phoneNumber, cardName: "PHONE NUMBER", placeholder: "Edit Phone Number")
                    
                    EditCard(field: $settingsViewModel.location, cardName: "LOCATION", placeholder: "Edit Location")
                }
                .padding(.horizontal)

                PersonalInfoButtonOptions()
                    .padding()
            }
            .setScrollViewBackground()
            .toolbar(.hidden, for: .tabBar)
            .navigationTitle("Personal Information")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct EditCard: View {
    @Binding var field: String
    let cardName: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(cardName)
                .sectionTitleStyle()
            
            HStack {
                TextField(placeholder, text: $field)
                    .font(.system(.body, weight: .medium))
                    .foregroundStyle(.primaryText)
                    .autocorrectionDisabled()
                
                if !field.isEmpty {
                    Button {
                        field = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color.secondary.opacity(0.5))
                    }
                }
            }
            .padding(.horizontal, 26)
            .padding(.vertical, 12)
        }
        .padding(.vertical)
        .createCardBackgroud()
    }
}

private struct PersonalInfoButtonOptions: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .padding()
                    .foregroundStyle(Color.secondaryText)
                    .frame(maxWidth: .infinity)
                    .background(Color.secondaryBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                Color.secondaryText.opacity(0.2)
                            )
                    )
            }
            
            Button {
                
            } label: {
                Text("Save Changes")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.white)
                    .background(.accentBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
            }
        }
    }
}

#Preview {
    PersonalInfoScreen()
        .environment(AppState())
}
