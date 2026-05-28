//
//  LoginViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import Observation
import Foundation

@Observable
class LoginViewModel {
    var username: String = ""
    var password: String = ""

    var showErrorAlert: Bool = false
    var toastOption: ToastOption = .idle
    var errorMessage: String = "Login"
    
    var didLoginSucceed: Bool = false
    
    private let userAuthService: UserAuthServiceProtocol
        
    init(userAuthService: UserAuthServiceProtocol) {
        self.userAuthService = userAuthService
    }
    
    func login() async {
        errorMessage = "Login"
        
        do {
            let request = UserLoginRequest(username: username, password: password)
            let _ = try await userAuthService.login(requestBody: request)
            
            toastOption = .success
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.didLoginSucceed = true
            }
        } catch let error as APIError {
            errorMessage = error.errorDescription
            toastOption = .failure
        } catch {
            errorMessage = "There was an unexpected error"
            toastOption = .failure
        }
    }
}
