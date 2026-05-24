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
    var errorMessage: String?
    
    var didLoginSucceed: Bool = false
    
    private let userAuthService: UserAuthServiceProtocol
        
    init(userAuthService: UserAuthServiceProtocol) {
        self.userAuthService = userAuthService
    }
    
    func login() async {
        errorMessage = nil
        
        do {
            let request = UserLoginRequest(username: username, password: password)
            let _ = try await userAuthService.login(requestBody: request)
            
            didLoginSucceed = true
            toastOption = .success
        } catch let error as APIError {
            toastOption = .failure
            print("There was a network error: \(error).")
        } catch {
            toastOption = .failure
            print("There was an unexpected error.")
        }
    }
}
