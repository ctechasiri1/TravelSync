//
//  PersonalInfoScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/24/26.
//

import SwiftUI

struct PersonalInfoScreen: View {
    @Environment(AppState.self) private var appState
    @State var profileUIImage: UIImage? = nil
    
    var body: some View {
        @Bindable var userSessionViewModel = appState.userSession
        
        ScrollView {
            VStack {
                ProfileImage(profileUIImage: $profileUIImage, canEditPhoto: true)
                    .frame(width: 140, height: 140)
                    .padding(.vertical, 10)
                
                Text("PROFILE PHOTO")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.secondaryText)
            }
            
            VStack(spacing: 25) {
                InputTextField(
                    text: $userSessionViewModel.username,
                    fieldTitle: "USERNAME",
                    fieldImage: "pencil",
                    fieldContent: "Edit Username",
                    iconColor: .gray
                )
                
                InputTextField(
                    text: $userSessionViewModel.fullName,
                    fieldTitle: "FULL NAME",
                    fieldImage: "person.fill",
                    fieldContent: "Edit Name",
                    iconColor: .gray
                )
                
                InputTextField(
                    text: $userSessionViewModel.email,
                    fieldTitle: "EMAIL",
                    fieldImage: "envelope.fill",
                    fieldContent: "Edit Email",
                    iconColor: .gray
                )
            }
            .padding()
            
            AuthButton(
                text: "Save Changes",
                foregroundColor: .white,
                backgroundColor: .accentPrimary
            ) {
                
            }
            .padding()
        }
        
        .setScrollViewBackground()
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Personal Information")
        .navigationBarTitleDisplayMode(.inline)
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

#Preview {
    PersonalInfoScreen()
        .environment(AppState())
}
