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
    var fullName: String = ""
    var username: String = ""
    var email: String = ""
    var password: String = ""

    var isNetworkActive: Bool = false
    var showErrorAlert: Bool = false
    var errorMessage: String?
    
    var loadingValue: Double = 0
    var loadingTimer: Timer?
    var loginAppState: LoginState = .loading
    
    private let userAuthService: UserAuthServiceProtocol
        
    init(userAuthService: UserAuthServiceProtocol = UserAuthService()) {
        self.userAuthService = userAuthService
    }
    
    func startLoading() {
        loadingTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.loadingValue += 0.2
            
            if self.loadingValue > 1 {
                self.loadingValue = 0
                self.loginAppState = .login
                timer.invalidate()
            }
        })
    }
    
    func signup() async {
        isNetworkActive = true
        errorMessage = nil
        
        do {
            let request = UserCreateRequest(username: username, fullName: fullName, email: email, password: password)
            let _ = try await userAuthService.signUp(requestBody: request)
            
            await login()
        } catch {
            errorMessage = "Failed to create account. That email or username might be taken."
            showErrorAlert = true
        }
        isNetworkActive = false
    }

    func login() async {
        isNetworkActive = true
        errorMessage = nil
        
        do {
            let request = UserLoginRequest(username: self.email, password: self.password)
            let _ = try await userAuthService.login(requestBody: request)
            
            loginAppState = .home
        } catch {
            self.errorMessage = "Login failed. Please check your email and password"
            self.showErrorAlert = true
            print("Login Error: \(error.localizedDescription)")
        }
        isNetworkActive = false
    }
}
