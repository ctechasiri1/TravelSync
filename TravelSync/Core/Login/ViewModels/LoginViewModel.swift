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
    // For Login & Sign Up Screen
    var fullName: String = ""
    var username: String = ""
    var email: String = ""
    var password: String = ""

    // MARK: - UI State Properties (Bound to Alerts, Spinners, and Navigation)
    var isNetworkActive = false
    var isAuthenticated = false
    var showErrorAlert = false
    var errorMessage: String?
    
    // For Loading Screen
    var loadingValue: Float = 0
    var loadingTimer: Timer?
    var navigateToLoginScreen: Bool = false
    
    // 2. Dependency Injection: Better for testing!
    private let userAuthService: UserAuthServiceProtocol
        
    init(userAuthService: UserAuthServiceProtocol = UserAuthService()) {
        self.userAuthService = userAuthService
    }
    
    func startLoading() {
        loadingTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.loadingValue += 10
            print("Loading: \(self.loadingValue)")
            
            if self.loadingValue > 100 {
                self.navigateToLoginScreen = true
                timer.invalidate()
                self.loadingValue = 0
                print("Loading Finished")
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
            
            isAuthenticated = true
        } catch {
            self.errorMessage = "Login failed. Please check your email and password"
            self.showErrorAlert = true
            print("Login Error: \(error.localizedDescription)")
        }
        isNetworkActive = false
    }
}
