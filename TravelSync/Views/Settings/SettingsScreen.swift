//
//  SettingsScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/3/26.
//

import SwiftUI

struct SettingsScreen: View {
    @State private var viewModel: SettingsViewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    AccountOptions()
                    
                    PreferencesOptions(viewModel: viewModel)
                    
                    SupportOptions()
                    
                    LogOutButton()
                    
                    Text("Version 2.4.0 (145)")
                        .font(.subheadline)
                        .foregroundStyle(Color.textColor.secondaryText)
                }
                .padding(.top)
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

private struct AccountOptions: View {
    var body: some View {
        OptionsCard(title: "ACCOUNT") {
            NavigationOptionRow(title: "Personal Information", iconName: "person.fill", iconColor: .secondary, destination: PersonalInfoScreen(), useCircleIcon: false)
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
            ToggleOptionRow(title: "Push Notifications", iconName: "bell.fill", isOn: $viewModel.pushNotificationsIsOn)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            Divider()
            
            ToggleOptionRow(title: "Email Notifications", iconName: "lock.fill", isOn: $viewModel.emailNotificationsIsOn)
                .padding(.top, 10)
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
    SettingsScreen()
}
