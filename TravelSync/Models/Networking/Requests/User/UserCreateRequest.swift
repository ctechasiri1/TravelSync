//
//  UserCreateRequest.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/20/26.
//

import Foundation

struct UserCreateRequest: Codable {
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
