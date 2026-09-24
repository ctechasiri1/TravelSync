//
//  AuthContainer.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/23/26.
//

import Foundation

@MainActor
struct TSAuthContainer {
    private let overlayState: TSOverlayState
    private let authState: TSAuthState
    
    private let managerContainer: TSManagerContainer
    
    init(overlayState: TSOverlayState, authState: TSAuthState, managerContainer: TSManagerContainer) {
        self.overlayState = overlayState
        self.authState = authState
        self.managerContainer = managerContainer
    }
    
    func makeLoginViewModel() -> TSLoginViewModel {
        TSLoginViewModel(overlayState: overlayState, authState: authState, authManager: managerContainer.authManager)
    }
    
    func makeSignUpViewModel() -> TSSignUpViewModel {
        TSSignUpViewModel(overlayState: overlayState, authState: authState, authManager: managerContainer.authManager)
    }
}
