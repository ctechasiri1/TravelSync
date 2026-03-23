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
                    .padding(.vertical, 10)
                
                VStack(spacing: 5) {
                    InputTextField(
                        text: $settingsViewModel.userName,
                        fieldTitle: "USERNAME",
                        fieldImage: "pencil",
                        fieldContent: "Edit Username",
                        iconColor: .gray
                    )
                    
                    InputTextField(
                        text: $settingsViewModel.fullName,
                        fieldTitle: "FULL NAME",
                        fieldImage: "person.fill",
                        fieldContent: "Edit Name",
                        iconColor: .gray
                    )
                    
                    InputTextField(
                        text: $settingsViewModel.emailAddress,
                        fieldTitle: "EMAIL",
                        fieldImage: "envelope.fill",
                        fieldContent: "Edit Email",
                        iconColor: .gray
                    )
                    
                    InputTextField(
                        text: $settingsViewModel.password,
                        isSecureField: true,
                        toggleSecurityButton: true,
                        fieldTitle: "PASSWORD",
                        fieldImage: "lock.fill",
                        fieldContent: "Edit Password",
                        iconColor: .gray
                    )
                }
                .padding()

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
                    .background(.accentPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
            }
        }
    }
}

#Preview {
    PersonalInfoScreen()
        .environment(AppState())
}
