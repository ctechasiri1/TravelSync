//
//  ProfileViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//

import Observation
import Foundation

@Observable
class ProfileViewModel {
    var notificationIsOn: Bool = false
    var privacyIsOn: Bool = false
    var currentUser: User? = nil
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func getUser() async -> Void {
        do {
            let user = try await userService.getCurrentUser()
            self.currentUser = User(
                id: user.id,
                username: user.username,
                fullName: user.fullName,
                email: user.email,
                profileImage: user.imagePath
            )
        } catch {
            
        }
    }
}
