//
//  Trip.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//

import Foundation
import PhotosUI
import SwiftUI

struct Trip: Identifiable, Equatable {
    let id: Int
    let tripName: String
    let location: String
    let budget: String
    let startDate: Date
    let endDate: Date
    let imageURLString: URL?
    
    @MainActor
    static var example: Trip {
        return Trip(
            id: 1,
            tripName: "Mango Sticky Rice Summer",
            location: "Bangkok, Thailand",
            budget: "5000",
            startDate: Calendar.current.date(byAdding: .day, value: 2, to: Date.now) ?? .now,
            endDate: Calendar.current.date(byAdding: .day, value: 3, to: Date.now) ?? .now,
            imageURLString: nil
        )
    }
}

extension Trip {
    var dateRangeString: String {
        startDate.dateToStringRange(to: endDate)
    }
    
    var dateDiffernce: String {
        return Date.now.dateToDifferenceString(to: endDate)
    }
    
    var city: String {
        let cityCountryPairArray = location.split(separator: ",")

        return String(cityCountryPairArray[0]).trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    }
    
    var country: String {
        let cityCountryPairArray = location.split(separator: ",")

        return String(cityCountryPairArray[1]).trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    }
}

// MARK: DTO (Date Transfer Object) for the networking layer
struct TripCreateRequest {
    let tripName: String
    let location: String
    let budget: String
    let startDate: Date
    let endDate: Date
    let coverImageData: Data?
}

struct TripPrivateResponse: Codable {
    let id: Int
    let tripName: String
    let location: String
    let budget: String
    let startDateString: String
    let endDateString: String
    let imageURLString: String
    
    enum CodingKeys: String, CodingKey {
            case id
            case tripName = "title"
            case location
            case budget
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
