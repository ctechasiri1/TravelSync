//
//  SettingsScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/3/26.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(AppState.self) private var appState
    let user: User
    
    var body: some View {
        @Bindable var settingsViewModel = appState.settings
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    ProfileInformation(user: user)
                    
                    AccountOptions()
                    
                    PreferencesOptions(viewModel: settingsViewModel)
                    
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
    
    var body: some View {
        OptionsCard(title: "") {
            HStack(spacing: 0) {
                AsyncImage(url: URL(string: user.profileImage)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                } placeholder: {
                    ZStack {
                        Color.gray.opacity(0.5)
                            .clipShape(Circle())
                        
                        ProgressView()
                            .padding()
                    }
                    .padding()
                    .frame(width: 100)
                }
                
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
    var body: some View {
        OptionsCard(title: "ACCOUNT") {
            NavigationOptionRow(title: "Personal Information", iconName: "person.fill", iconColor: .secondary, destination: PersonalInfoScreen().environment(SettingsViewModel()), useCircleIcon: false)
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

private struct PreferencesOptions: View {
    @Bindable var viewModel: SettingsViewModel
    
    var body: some View {
        OptionsCard(title: "PREFERNCES") {
            ToggleOptionRow(title: "Notifications", iconName: "lock.fill", isOn: $viewModel.emailNotificationsIsOn)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            Divider()
            
            ToggleOptionRow(title: "Dark Mode", iconName: "moon.fill", isOn: $viewModel.darkModeIsOn)
                .padding(.top, 10)
                .padding(.bottom, 10)
            
            Divider()
            
            NavigationOptionRow(title: "Language", iconName: "globe", iconColor: .secondary, destination: EmptyView(), useCircleIcon: false)
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
    SettingsScreen(user: User.example)
        .environment(AppState())
}
