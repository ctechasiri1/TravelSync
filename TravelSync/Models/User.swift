//
//  User.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/21/26.
//

import Foundation

struct User {
    let id: Int
    let username: String
    let fullName: String
    let email: String
    let profileImage: String
}

extension User {
    var firstName: String {
        let firstName = fullName.split(separator: " ")[0]
        return String(firstName)
    }
}

// MARK: DTO (Date Transfer Object) for the networking layer
struct UserCreateRequest: Encodable {
    let username: String
    let fullName: String
    let email: String
    let password: String

    enum CodingKeys: String, CodingKey {
        case username
        case fullName = "full_name"
        case email
        case password
    }
}

struct UserPrivateResponse: Decodable {
    let id: Int
    let username: String
    let fullName: String
    let email: String
    let imagePath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case fullName = "full_name"
        case email
        case imagePath = "profile_image_path"
    }
}

struct UserLoginRequest: Encodable {
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
}
