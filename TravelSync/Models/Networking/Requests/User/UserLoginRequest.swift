//
//  UserLoginRequest.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/20/26.
//

import Foundation

struct UserLoginRequest: Encodable {
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
}
