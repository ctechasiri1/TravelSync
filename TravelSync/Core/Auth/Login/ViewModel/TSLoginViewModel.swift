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
    
    private let appState: TSAppState
    private let authManager: TSUserAuthManger
        
    init(appState: TSAppState, authManager: TSUserAuthManger) {
        self.appState = appState
        self.authManager = authManager
    }
    
    func login() {
        appState.showLoader()
        
        Task {
            do {
                try await authManager.login(username: username, password: password)
                
                appState.hideLoader()
                appState.setToast(to: .success(message: "Login"))
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.appState.navigate(to: .home)
                }
            } catch let error as APIError {
                appState.setToast(to: .failure(message: error.errorDescription))
            } catch {
                // TODO: there is a better way to handle this maybe just a default in the error options or localized string
                appState.setToast(to: .failure(message: "There was an unexpected error"))
            }
        }
    }
}
