//
//  UserPrivateResponse.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/20/26.
//

import Foundation

struct UserPrivateResponse: Decodable, Sendable {
    let id: Int
    let username: String
    let fullName: String
    let email: String
    let profileImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case fullName = "full_name"
        case email
        case profileImageURL = "profile_image_url"
    }
    
    static var example: UserPrivateResponse {
        return User(
            id: 1,
            username: "ctechasiri",
            fullName: "Chiraphat Techasiri",
            email: "ctechasiri@gmail.com",
            profileImage: ""
        )
    }
    
    func toDomain() -> User {
        User(
            id: id,
            username: username,
            fullName: fullName,
            email: email,
            profileImage: profileImageURL
        )
    }
}
