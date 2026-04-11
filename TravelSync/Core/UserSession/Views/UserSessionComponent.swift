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
            ToggleOptionRow(title: "Notifications", iconName: "bell.fill", isOn: $viewModel.emailNotificationsIsOn)
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

#Preview {
    PreferencesOptions(viewModel: UserSessionViewModel())
        .environment(AppState())
}
