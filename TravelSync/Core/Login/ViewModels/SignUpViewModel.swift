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
    var toastOption: ToastOption = .idle
    var errorMessage: String?
    
    var didSignUpSucceed: Bool = false
    
    private let userAuthService: UserAuthServiceProtocol
        
    init(userAuthService: UserAuthServiceProtocol) {
        self.userAuthService = userAuthService
    }
    
    func signup() async {
        defer { isNetworkActive = false }
        
        isNetworkActive = true
        errorMessage = nil
        
        do {
            let request = UserCreateRequest(username: username, fullName: fullName, email: email, password: password)
            let _ = try await (Task.sleep(nanoseconds: 500_000_000), userAuthService.signUp(requestBody: request))
            
            toastOption = .success
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.didSignUpSucceed = true
            }
        } catch let error as APIError {
            toastOption = .failure
            errorMessage = error.errorDescription
        } catch {
            toastOption = .failure
            errorMessage = "There was an unexpected error"
        }
    }
}
