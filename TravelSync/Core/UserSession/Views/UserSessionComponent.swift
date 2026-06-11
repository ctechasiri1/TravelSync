//
//  UserSessionComponent.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/10/26.
//

import SwiftUI

struct PreferencesOptions: View {
    @Bindable var viewModel: UserSessionViewModel
    
    var body: some View {
        OptionsCard(title: "PREFERNCES") {
            ToggleOptionRow(isOn: $viewModel.emailNotificationsIsOn, title: "Notifications", iconName: "bell.fill")
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            Divider()
            
            ToggleOptionRow(isOn: $viewModel.darkModeIsOn, title: "Dark Mode", iconName: "moon.fill")
                .padding(.top, 10)
                .padding(.bottom, 20)
        }
    }
}

#Preview {
    PreferencesOptions(viewModel: UserSessionViewModel(userService: UserService(networkService: NetworkRequestService(), keychainService: KeychainService())))
        .environment(AppState())
}
