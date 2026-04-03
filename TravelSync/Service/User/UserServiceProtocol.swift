//
//  UserServiceProtocol.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/2/26.
//

import Foundation

protocol UserServiceProtocol {
    func getCurrentUser() async throws -> UserPrivateResponse
}
