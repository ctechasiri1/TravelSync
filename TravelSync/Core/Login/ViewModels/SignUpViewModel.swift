//
//  SignUpViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/13/26.
//

import Observation
import Foundation

@Observable
class SignUpViewModel {
    var fullName: String = ""
    var username: String = ""
    var email: String = ""
    var password: String = ""
    
    var isNetworkActive: Bool = false
    var showErrorAlert: Bool = false
    var errorMessage: String?
    
    var didSignUpSucceed: Bool = false
    
    private let userAuthService: UserAuthServiceProtocol
        
    init(userAuthService: UserAuthServiceProtocol) {
        self.userAuthService = userAuthService
    }
    
    func signup() async {
        isNetworkActive = true
        errorMessage = nil
        
        do {
            let request = UserCreateRequest(username: username, fullName: fullName, email: email, password: password)
            let _ = try await userAuthService.signUp(requestBody: request)
            
            didSignUpSucceed = true
        } catch {
            errorMessage = "Failed to create account. That email or username might be taken."
            showErrorAlert = true
        }
        isNetworkActive = false
    }
}
