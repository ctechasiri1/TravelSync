//
//  UserMockService.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/5/26.
//

import Foundation

struct UserMockService: UserServiceProtocol {
    func getCurrentUser() async throws -> UserPrivateResponse {
        return UserPrivateResponse(
            id: 1,
            username: "Ctechasiri",
            fullName: "Chiraphat Techasiri",
            email: "ctechasiri@gmail.com",
            imagePath: "http://127.0.0.1:8000/static/profile_image/default.pgn"
        )
    }
}
