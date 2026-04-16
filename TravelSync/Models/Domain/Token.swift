//
//  Token.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/23/26.
//

import Foundation

struct TokenResponse: Decodable {
    let accessToken: String
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}

