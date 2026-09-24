//
//  TSAuthState.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/23/26.
//

import Observation
import Foundation

@Observable
@MainActor

final class TSAuthState {
    private(set) var currentAuthScreen: AuthState = .loading
    private(set) var prevAuthScreen: AuthState?
    private(set) var hasBooted: Bool = false
    
    func setAuthScreen(to screen: AuthState) {
        currentAuthScreen = screen
    }
    
    func setPrevAuthScreen(to screen: AuthState) {
        prevAuthScreen = screen
    }
    
    func navigate(to flow: AuthState) {
        currentAuthScreen = flow
    }
    
    func setHasBooted(to state: Bool) {
        hasBooted = state
    }
}
