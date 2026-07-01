//
//  AppState+DI.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/15/26.
//

import Observation
import Foundation

@Observable
class AppState {
    var currentAuthScreen: LoginState = .loading
    var isNotificationEnabled: Bool = false
    var isDarkModeEnabled: Bool = false
    
    let services: ServiceContainer
    let managers: ManagerContainer
    
    init(services: ServiceContainer = ServiceContainer(), managers: ManagerContainer = ManagerContainer()) {
        self.services = services
        self.managers = managers
    }
    
    func navigate(to flow: LoginState) {
        currentAuthScreen = flow
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(userAuthService: services.authService)
    }
    
    func makeSignUpViewModel() -> SignUpViewModel {
        SignUpViewModel(userAuthService: services.authService, loadingManager: managers.loadingManager)
    }
    
    func makeTripFeedViewModel() -> TripsFeedViewModel {
        TripsFeedViewModel(tripService: services.tripService)
    }
    
    func makeTripDetailViewModel() -> TripDetailViewModel {
        TripDetailViewModel(tripService: services.tripService, loadingManager: managers.loadingManager, weatherKitService: services.weatherKitService)
    }
    
    func makePlanNewTripViewModel() -> PlanNewTripViewModel {
        PlanNewTripViewModel(tripService: services.tripService, locationSearchManager: managers.locationSearchManager, loadingManager: managers.loadingManager)
    }
    
    func makeUserSessionViewModel() -> UserSessionViewModel {
        UserSessionViewModel(userService: services.userService)
    }
    
    func makeBudgetViewModel() -> BudgetViewModel {
        BudgetViewModel(expenseService: services.expenseService, tripService: services.tripService, loadingManager: managers.loadingManager)
    }
    
    func makeAddExpenseViewModel() -> AddExpenseViewModel {
        AddExpenseViewModel(expenseService: services.expenseService, loadingManager: managers.loadingManager)
    }
    
    func makeCalendarViewModel() -> CalendarViewModel {
        CalendarViewModel()
    }
    
    func makeEventMapViewModel() -> EventMapViewModel {
        EventMapViewModel()
    }
}
