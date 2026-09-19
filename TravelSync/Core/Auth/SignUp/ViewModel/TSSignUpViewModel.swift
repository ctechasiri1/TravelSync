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
    
    private let appState: TSAppState
    private let userAuthService: TSUserAuthService
        
    init(appState: TSAppState, userAuthService: TSUserAuthService) {
        self.appState = appState
        self.userAuthService = userAuthService
    }
    
    func signup() {
        defer { appState.hideLoader() }
        
        appState.showLoader()
        
        Task {
            do {
                let request = UserCreateRequest(username: username, fullName: fullName, email: email, password: password)
                let _ = try await (Task.sleep(nanoseconds: 500_000_000), userAuthService.signUp(requestBody: request))
                
                appState.setToast(to: .success(message: "Sign Up"))
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.appState.navigate(to: .login)
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
