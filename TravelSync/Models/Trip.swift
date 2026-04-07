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
        let formatter = DateIntervalFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter.string(from: startDate, to: endDate)
    }
    
    var dateDiffernce: String? {
        let differnceFormatter = DateComponentsFormatter()
        differnceFormatter.allowedUnits = .day
        differnceFormatter.unitsStyle = .full
        
        if let dateDiffernce = differnceFormatter.string(from: .now, to: startDate) {
            return dateDiffernce.capitalized
        } else {
            print("There was an error getting date differnce")
            return nil
        }
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: startDateString) {
            print("START DATE TRIGGERED")
            return date
        } else {
            return Date()
        }
    }
    
    var endDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: endDateString) {
            print("END DATE TRIGGERED")
            return date
        } else {
            return Date()
        }
    }
    
    var imageURL: URL? {
        if let url = URL(string: imageURLString) {
            return url
        } else {
            return nil
        }
    }
}
