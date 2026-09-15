//
//  DIContainer.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/7/26.
//

import Observation
import Foundation

@Observable
class TSViewModelFactory {
    let appState: TSAppState

    private var services: ServiceContainer { appState.services }
    private var managers: ManagerContainer { appState.managers }
    
    init(appState: TSAppState) {
        self.appState = appState
    }
    
    func makeLoginViewModel() -> TSLoginViewModel {
        TSLoginViewModel(appState: appState, userAuthService: services.authService)
    }
    
    func makeSignUpViewModel() -> TSSignUpViewModel {
        TSSignUpViewModel(appState: appState, userAuthService: services.authService)
    }
    
    func makeTripFeedViewModel() -> TripsFeedViewModel {
        TripsFeedViewModel(tripService: services.tripService)
    }
    
//    func makeTripDetailViewModel() -> TripDetailViewModel {
//        TripDetailViewModel(tripService: services.tripService, loadingManager: managers.loadingManager, weatherKitService: services.weatherKitService)
//    }
//    
//    func makePlanNewTripViewModel() -> PlanNewTripViewModel {
//        PlanNewTripViewModel(tripService: services.tripService, locationSearchManager: managers.locationSearchManager, loadingManager: managers.loadingManager)
//    }
    
    func makeUserSessionViewModel() -> UserSessionViewModel {
        UserSessionViewModel(userService: services.userService)
    }
    
//    func makeBudgetViewModel() -> BudgetViewModel {
//        BudgetViewModel(expenseService: services.expenseService, tripService: services.tripService, loadingManager: managers.loadingManager)
//    }
//    
//    func makeAddExpenseViewModel() -> AddExpenseViewModel {
//        AddExpenseViewModel(expenseService: services.expenseService, loadingManager: managers.loadingManager)
//    }
    
    func makeCalendarViewModel() -> CalendarViewModel {
        CalendarViewModel()
    }
    
    func makeEventMapViewModel() -> EventMapViewModel {
        EventMapViewModel()
    }
}
