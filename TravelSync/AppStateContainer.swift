//
//  Container.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/3/26.
//

import Observation
import Foundation

@Observable
class AppState {
    var login = LoginViewModel()
    
    var tripsFeed = TripsFeedViewModel()
    var tripDetail = TripDetailViewModel()
    var planNewTrip = PlanNewTripViewModel()
    
    var userSession = UserSessionViewModel()

    var budget = BudgetViewModel()
}
