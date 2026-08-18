//
//  SettingsScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/3/26.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: UserSessionViewModel
    
    let user: User
    
    init(user: User, viewModel: UserSessionViewModel) {
        _viewModel = State(wrappedValue: viewModel)
        self.user = user
    }
    
    var body: some View {
        ZStack {
            Color.secondaryBackground.opacity(0.5)
            
            List {
                ProfileInformationSection(user: viewModel.currentUser, selectedProfileImage: viewModel.selectedProfileImage)
                
                AccountOptionSection(user: user, viewModel: viewModel)
                
                SupportOptions()
                
                Group {
                    TSFillButton(
                        title: "Log Out",
                        foregroundColor: .accentPrimary,
                        backgroundColor: .white) {
                            
                        }
                        .padding(.vertical, 12)
                        
                    Text("Version 2.4.0 (145)")
                        .font(.subheadline)
                        .foregroundStyle(.secondaryText)
                        .frame(maxWidth: .infinity)
                }
                .removeListRowFormatting()
                
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
        }
    }
}

private struct ProfileInformationSection: View {
    
    let user: User
    let selectedProfileImage: UIImage?

    var body: some View {
        Section {
            HStack(spacing: 0) {
                ProfileImage(
                    imageURL: user.profileImage,
                    selectedImage: selectedProfileImage
                )
                .frame(width: 40, height: 40)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                VStack(alignment: .leading) {
                    Text(user.fullName)
                        .font(.system(.headline, weight: .semibold))
                    
                    Text(user.email)
                        .font(.system(.subheadline))
                        .foregroundStyle(.secondaryText)
                }
                Spacer()
            }
            .padding()
        }
    }
}

private struct AccountOptionSection: View {
    let user: User
    
    let viewModel: UserSessionViewModel
    var body: some View {
        Section("ACCOUNT") {
            TSNavigationRow(title: "Personal Information", iconName: TSSystemImage.personFill) {
                EditPersonalInfoScreen(user: user, viewModel: viewModel)
            }
            .padding(16)
            
            TSNavigationRow(title:"Security & Password", iconName: TSSystemImage.lockFill) {
                EditPersonalInfoScreen(user: user, viewModel: viewModel)
            }
            .padding(16)
        }
    }
}

private struct SupportOptions: View {
    var body: some View {
        Section("SUPPORT") {
            TSNavigationRow(title:"Help Center", iconName: TSSystemImage.questionmarkAppFill) {
                EmptyView()
            }
            .padding(16)
            
            TSNavigationRow(title:"Security & Password", iconName: TSSystemImage.bookPagesFill) {
                TermsOfServiceScreen()
            }
            .padding(16)
            
            TSNavigationRow(title:"Privacy Policy", iconName: TSSystemImage.lockShieldFill) {
                PrivacyPolicyScreen()
            }
            .padding(16)

        }
    }
}

#Preview {
    NavigationStack {
        SettingsScreen(
            user: User.example,
            viewModel: UserSessionViewModel(
                userService: UserService(
                    networkService: NetworkRequestService(),
                    keychainService: KeychainService()
                )
            )
        )
    }
        .environment(AppState())
}
