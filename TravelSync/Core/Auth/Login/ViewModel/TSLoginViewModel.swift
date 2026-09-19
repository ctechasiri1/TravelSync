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
    
    private let userAuthService: TSUserAuthService
    private let appState: TSAppState
        
    init(appState: TSAppState, userAuthService: TSUserAuthService) {
        self.appState = appState
        self.userAuthService = userAuthService
    }
    
    func login() {
        appState.showLoader()
        
        Task {
            do {
                let request = UserLoginRequest(username: username, password: password)
                let _ = try await userAuthService.login(requestBody: request)
                
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
