//
//  TripUpdateRequest.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/13/26.
//

import Foundation

struct TripUpdateRequest {
    let id: Int
    let isFavorite: Bool?
    let coverImageData: Data?
}
