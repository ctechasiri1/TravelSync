//
//  TSLoginViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import Observation
import Foundation

@Observable
class TSLoginViewModel {
    var username: String = ""
    var password: String = ""
    
    // TODO: need to be able to pass message into the toast so errors can be customized
    var didLoginSucceed: Bool = false
    
    private let userAuthService: UserAuthServiceProtocol
    private let appState: TSAppState
        
    init(appState: TSAppState, userAuthService: UserAuthServiceProtocol) {
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
                appState.setToast(to: .success, with: "Login")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.didLoginSucceed = true
                }
            } catch let error as APIError {
                appState.setToast(to: .failure, with: error.errorDescription)
            } catch {
                appState.setToast(to: .failure, with: "There was an unexpected error")
            }
        }
    }
}
