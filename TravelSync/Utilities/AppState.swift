//
//  TSAppState.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/15/26.
//

import Observation
import Foundation

@Observable
class TSAppState {
    
    private(set) var currentAuthScreen: AuthState = .loading
    private(set) var prevAuthScreen: AuthState?
    private(set) var toastOption: ToastOption = .idle
    
    private(set) var hasBooted: Bool = false
    private(set) var isLoading: Bool = false
    var isNotificationEnabled: Bool = false
    var isDarkModeEnabled: Bool = false
    
    private(set) var toastMessage: String = ""
    
    let services: ServiceContainer
    let managers: ManagerContainer
    
    init(services: ServiceContainer = ServiceContainer(), managers: ManagerContainer = ManagerContainer()) {
        self.services = services
        self.managers = managers
    }
    
    func navigate(to flow: AuthState) {
        currentAuthScreen = flow
    }
    
    func setToast(to option: ToastOption, with message: String) {
        toastOption = option
        toastMessage = message
    }
    
    func hideToast() {
        toastOption = .idle
    }
    
    func setAuthScreen(to screen: AuthState) {
        currentAuthScreen = screen
    }
    
    func setPrevAuthScreen(to screen: AuthState) {
        prevAuthScreen = screen
    }
    
    func setHasBooted(to state: Bool) {
        hasBooted = state
    }
    
    func showLoader() {
        isLoading = true
    }
    
    func hideLoader() {
        isLoading = false
    }
}
