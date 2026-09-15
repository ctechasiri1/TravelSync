//
//  TSSignUpViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/13/26.
//

import Observation
import Foundation

@Observable
class TSSignUpViewModel {
    var fullName: String = ""
    var username: String = ""
    var email: String = ""
    var password: String = ""
    
    var isNetworkActive: Bool = false
    var didSignUpSucceed: Bool = false
    
    private let appState: TSAppState
    private let userAuthService: UserAuthServiceProtocol
        
    init(appState: TSAppState, userAuthService: UserAuthServiceProtocol) {
        self.appState = appState
        self.userAuthService = userAuthService
    }
    
    func signup() async {
        defer { appState.hideLoader() }
        
        appState.showLoader()
        
        do {
            let request = UserCreateRequest(username: username, fullName: fullName, email: email, password: password)
            let _ = try await (Task.sleep(nanoseconds: 500_000_000), userAuthService.signUp(requestBody: request))
            
            appState.setToast(to: .success, with: "Sign Up")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.didSignUpSucceed = true
            }
        } catch let error as APIError {
            appState.setToast(to: .failure, with: error.errorDescription)
        } catch {
            appState.setToast(to: .failure, with: "There was an unexpected error")
        }
    }
}
