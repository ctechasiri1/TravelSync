//
//  TripPrivateResponse.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/13/26.
//

import Foundation

struct TripPrivateResponse: Codable {
    let id: Int
    let tripName: String
    let location: String
    let budget: Int
    let isFavorite: Bool
    let startDateString: String
    let endDateString: String
    let imageURLString: String
    
    enum CodingKeys: String, CodingKey {
            case id
            case tripName = "title"
            case location
            case budget
            case isFavorite = "is_favorite"
            case startDateString = "start_date"
            case endDateString = "end_date"
            case imageURLString = "cover_image_path"
        }
}

extension TripPrivateResponse {
    var startDate: Date {
        return startDateString.stringToDate
    }
    
    var endDate: Date {
        return endDateString.stringToDate
    }
    
    var imageURL: URL? {
        if let url = URL(string: imageURLString) {
            return url
        } else {
            return nil
        }
    }
}
