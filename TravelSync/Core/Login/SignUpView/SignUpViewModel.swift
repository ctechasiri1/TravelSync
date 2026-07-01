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
    var errorMessage: String = "Sign up"
    
    var didSignUpSucceed: Bool = false
    
    private let userAuthService: UserAuthServiceProtocol
    private let loadingManger: LoadingManager
        
    init(userAuthService: UserAuthServiceProtocol, loadingManager: LoadingManager) {
        self.userAuthService = userAuthService
        self.loadingManger = loadingManager
    }
    
    func signup() async {
        defer { loadingManger.hide() }
        
        loadingManger.show()
        
        errorMessage = "Sign up"
        
        do {
            let request = UserCreateRequest(username: username, fullName: fullName, email: email, password: password)
            let _ = try await (Task.sleep(nanoseconds: 500_000_000), userAuthService.signUp(requestBody: request))
            
            toastOption = .success
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.didSignUpSucceed = true
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
