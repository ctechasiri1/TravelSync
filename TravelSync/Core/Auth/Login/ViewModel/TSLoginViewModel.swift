//
//  TSLoginViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import Observation
import Foundation

@MainActor
@Observable
class TSLoginViewModel {
    var username: String = ""
    var password: String = ""
    
    private let overlayState: TSOverlayState
    private let authState: TSAuthState
    private let authManager: TSUserAuthManger
        
    init(overlayState: TSOverlayState, authState: TSAuthState, authManager: TSUserAuthManger) {
        self.overlayState = overlayState
        self.authState = authState
        self.authManager = authManager
    }
    
    func login() {
        overlayState.showLoader()
        
        Task {
            do {
                try await authManager.login(username: username, password: password)
                
                overlayState.hideLoader()
                overlayState.setToast(to: .success(message: "Login"))
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.authState.navigate(to: .home)
                }
            } catch let error as APIError {
                overlayState.setToast(to: .failure(message: error.errorDescription))
            } catch {
                // TODO: there is a better way to handle this maybe just a default in the error options or localized string
                overlayState.setToast(to: .failure(message: "There was an unexpected error"))
            }
        }
    }
}
