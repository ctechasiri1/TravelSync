//
//  TSAppConfigState.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/23/26.
//

import Observation
import Foundation

@Observable
@MainActor

final class TSAppConfigState {
    var isNotificationEnabled: Bool = false
    var isDarkModeEnabled: Bool = false
    
    func toggleNotification() {
        isNotificationEnabled.toggle()
    }
    
    func toggleDarkMode() {
        isDarkModeEnabled.toggle()
    }
}
