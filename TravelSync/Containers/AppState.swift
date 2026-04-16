//
//  AppState.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/15/26.
//

import Observation
import Foundation

@Observable
class AppState {
    var currentAuthScreen: LoginState = .loading
    
    let services: ServiceContainer
    
    init(services: ServiceContainer = ServiceContainer()) {
        self.services = services
    }
    
    func navigate(to flow: LoginState) {
        currentAuthScreen = flow
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(userAuthService: services.authService)
    }
    
    func makeSignUpViewModel() -> SignUpViewModel {
        SignUpViewModel(userAuthService: services.authService)
    }
    
    func makeTripFeedViewModel() -> TripsFeedViewModel {
        TripsFeedViewModel(tripService: services.tripService)
    }
    
    func makePlanNewTripViewModel() -> PlanNewTripViewModel {
        PlanNewTripViewModel(tripService: services.tripService)
    }
    
    func makeUserSessionViewModel() -> UserSessionViewModel {
        UserSessionViewModel(userService: services.userService)
    }
    
    func makeBudgetViewModel() -> BudgetViewModel {
        BudgetViewModel()
    }
}
