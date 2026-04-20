//
//  PersonalInfoScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/24/26.
//

import SwiftUI

struct PersonalInfoScreen: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: UserSessionViewModel
    
    let user: User
    
    init(user: User, viewModel: UserSessionViewModel) {
        _viewModel = State(wrappedValue: viewModel)
        self.user = user
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ProfileImage(
                    imageURL: viewModel.currentUser.profileImage,
                    selectedImage: viewModel.selectedProfileImage,
                    canEditPhoto: true
                ) { pickedImage in

                }
                .frame(width: 100, height: 100)
                
                Text("PROFILE PHOTO")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.secondaryText)
            }
            .padding()
            
            VStack(spacing: 25) {
                InputTextField(
                    text: $viewModel.username,
                    fieldTitle: "USERNAME",
                    fieldImage: "pencil",
                    fieldContent: "Edit Username",
                    iconColor: .gray
                )
                
                InputTextField(
                    text: $viewModel.fullName,
                    fieldTitle: "FULL NAME",
                    fieldImage: "person.fill",
                    fieldContent: "Edit Name",
                    iconColor: .gray
                )
                
                InputTextField(
                    text: $viewModel.email,
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
    PersonalInfoScreen(user: User.example, viewModel: UserSessionViewModel(userService: UserService(networkService: NetworkRequestService(), keychainService: KeychainService())))
        .environment(AppState())
}
