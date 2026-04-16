//
//  TripUpdateRequest.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/13/26.
//

import Foundation

struct TripUpdateRequest {
    let tripName: String?
    let location: String?
    let budget: Int?
    let isFavorite: Bool?
    let startDate: Date?
    let endDate: Date?
    let coverImageData: Data?
}
