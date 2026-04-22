//
//  UserSessionViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/10/26.
//

import Observation
import Foundation
import SwiftUI

@Observable
class UserSessionViewModel {
    var username: String = ""
    var fullName: String = ""
    var email: String = ""
    var selectedProfileImage: UIImage? = nil
    
    var pushNotificationsIsOn: Bool = false
    var emailNotificationsIsOn: Bool = false
    var darkModeIsOn: Bool = false
    
    var privacyIsOn: Bool = false
    var currentUser: User = User.example
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol) {
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
            print(error)
            print("There was an error retrieving user information")
        }
    }
    
    func updateUserProfileImage() async -> Void {

    }
}
