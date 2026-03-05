//
//  Container.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/3/26.
//

import Foundation

@Observable
class AppState {
    var settings = SettingsViewModel()
    var trips = TripsViewModel()
    var profile = ProfileViewModel()
    var planNewTrip = PlanNewTripViewModel()
}
