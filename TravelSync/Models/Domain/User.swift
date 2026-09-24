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
    
    static var mock: User {
        return User(
            id: 1,
            username: "ctechasiri",
            fullName: "Chiraphat Techasiri",
            email: "ctechasiri@gmail.com",
            profileImage: ""
        )
    }
}

extension User {
    var firstName: String {
        let firstName = fullName.split(separator: " ")[0]
        return String(firstName)
    }
}
