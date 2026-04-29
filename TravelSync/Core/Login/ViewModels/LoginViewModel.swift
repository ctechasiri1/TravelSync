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

    var isNetworkActive: Bool = false
    var showErrorAlert: Bool = false
    var errorMessage: String?
    
    var didLoginSucceed: Bool = false
    
    private let userAuthService: UserAuthServiceProtocol
        
    init(userAuthService: UserAuthServiceProtocol) {
        self.userAuthService = userAuthService
    }
    
    func login() async {
        defer { isNetworkActive = false }
        
        isNetworkActive = true
        errorMessage = nil
        
        do {
            let request = UserLoginRequest(username: username, password: password)
            let _ = try await userAuthService.login(requestBody: request)
            
            didLoginSucceed = true
        } catch let error as APIError {
//            self.showErrorAlert = true
//            self.errorMessage = "Login failed. Please check your email and password"
            print("There was a network error: \(error).")
        } catch {
            print("There was an unexpected error.")
        }
    }
}
