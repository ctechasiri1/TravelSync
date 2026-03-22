//
//  User.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/21/26.
//

import Foundation

struct User {
    let id = UUID().uuidString
    let username: String
    let fullName: String
    let phoneNumber: String
    let email: String
    let profileImage: String
    let pastTrips: [Trip]
    let currentTrips: [Trip]
}
