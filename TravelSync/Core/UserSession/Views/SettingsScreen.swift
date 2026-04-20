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
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    ProfileInformation(user: viewModel.currentUser, selectedProfileImage: viewModel.selectedProfileImage)

                    AccountOptions(user: user, viewModel: viewModel)
                    
                    PreferencesOptions(viewModel: viewModel)
                    
                    SupportOptions()
                    
                    AuthButton(
                        text: "Log Out",
                        foregroundColor: .accentPrimary,
                        backgroundColor: .white) {
                            
                        }
                    
                    Text("Version 2.4.0 (145)")
                        .font(.subheadline)
                        .foregroundStyle(Color.textColor.secondaryText)
                }
                .padding(.top)
                .padding(.horizontal)
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(.hidden, for: .tabBar)
            }
        }
    }
}

private struct ProfileInformation: View {
    let user: User
    let selectedProfileImage: UIImage?

    
    var body: some View {
        OptionsCard(title: "") {
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

private struct AccountOptions: View {
    let user: User
    
    let viewModel: UserSessionViewModel
    var body: some View {
        OptionsCard(title: "ACCOUNT") {
            NavigationOptionRow(title: "Personal Information", iconName: "person.fill", iconColor: .secondary, destination: PersonalInfoScreen(user: user, viewModel: viewModel), useCircleIcon: false)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            Divider()
            
            NavigationOptionRow(title: "Security & Password", iconName: "lock.fill", iconColor: .secondary, destination: EmptyView(), useCircleIcon: false)
                .padding(.top, 10)
                .padding(.bottom, 10)
            
            Divider()
            
            NavigationOptionRow(title: "Payments & Payouts", iconName: "creditcard.fill", iconColor: .secondary, destination: EmptyView(), useCircleIcon: false)
                .padding(.top, 10)
                .padding(.bottom, 20)
        }
    }
}

private struct SupportOptions: View {
    var body: some View {
        OptionsCard(title: "SUPPORT") {
            NavigationOptionRow(title: "Help Center", iconName: "questionmark.app.fill", iconColor: .secondary, destination: EmptyView(), useCircleIcon: false)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            Divider()
            
            NavigationOptionRow(title: "Terms of Service", iconName: "book.pages.fill", iconColor: .secondary, destination: TermsOfServiceScreen(), useCircleIcon: false)
                .padding(.top, 10)
                .padding(.bottom, 10)
            
            Divider()
            
            NavigationOptionRow(title: "Privacy Policy", iconName: "lock.shield.fill", iconColor: .secondary, destination: PrivacyPolicyScreen(), useCircleIcon: false)
                .padding(.top, 10)
                .padding(.bottom, 20)
        }
    }
}


#Preview {
    SettingsScreen(user: User.example, viewModel: UserSessionViewModel(userService: UserService(networkService: NetworkRequestService(), keychainService: KeychainService())))
        .environment(AppState())
}
