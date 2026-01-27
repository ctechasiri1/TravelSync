//
//  SettingsViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//

import Observation
import Foundation

@Observable
class SettingsViewModel {
    var pushNotificationsIsOn: Bool = false
    var emailNotificationsIsOn: Bool = false
    var darkModeIsOn: Bool = false
}
