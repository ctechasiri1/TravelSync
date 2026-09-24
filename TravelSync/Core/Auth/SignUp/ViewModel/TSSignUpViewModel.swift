//
//  TSSignUpViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/13/26.
//

import Observation
import Foundation

@MainActor
@Observable
class TSSignUpViewModel {
    var fullName: String = ""
    var username: String = ""
    var email: String = ""
    var password: String = ""
    
    private let overlayState: TSOverlayState
    private let authState: TSAuthState
    private let authManager: TSUserAuthManger
        
    init(overlayState: TSOverlayState, authState: TSAuthState, authManager: TSUserAuthManger) {
        self.overlayState = overlayState
        self.authState = authState
        self.authManager = authManager
    }
    
    func signup() {
        defer { overlayState.hideLoader() }
        
        overlayState.showLoader()
        
        Task {
            do {
                try await (Task.sleep(nanoseconds: 500_000_000), authManager.signUp(fullName: fullName, username: username, email: email, password: password))
                
                overlayState.setToast(to: .success(message: "Sign Up"))
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.authState.navigate(to: .login)
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
