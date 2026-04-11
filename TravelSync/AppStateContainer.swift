//
//  Container.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/3/26.
//

import Foundation

@Observable
class AppState {
    var userSession = UserSessionViewModel()
    var tripsFeed = TripsFeedViewModel()
    var login = LoginViewModel()
    var tripDetail = TripDetailViewModel()
    var budget = BudgetViewModel()
}
