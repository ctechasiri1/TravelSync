//
//  Trip.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//

import Foundation
import PhotosUI

struct Trip: Identifiable, Equatable {
    let id: UUID = UUID()
    let tripName: String
    let location: String
    let budget: String
    let startDate: Date
    let endDate: Date
    let coverImage: UIImage?
    
    static var example: [Trip] {
        return [
            Trip(
                tripName: "Summer in Thailand",
                location: "Bangkok, Thailand",
                budget: "1_000",
                startDate: Calendar.current.date(byAdding: .day, value: 2, to: Date.now) ?? .now,
                endDate: Calendar.current.date(byAdding: .day, value: 3, to: Date.now) ?? .now,
                coverImage: UIImage(named: "tempBackground")
            ),
            Trip(
                tripName: "Eating Pho in Vietnam",
                location: "Saigon, Vietnam",
                budget: "2_000",
                startDate: Calendar.current.date(byAdding: .day, value: -7, to: Date.now) ?? .now,
                endDate: Calendar.current.date(byAdding: .day, value: -5, to: Date.now) ?? .now,
                coverImage: UIImage(named: "tempBackground")
            ),
            Trip(tripName: "Travel to Taiwan",
                 location: "Taipei, Taiwan",
                 budget: "3_000",
                 startDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now) ?? .now,
                 endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date.now) ?? .now,
                 coverImage: UIImage(named: "tempBackground")
                )
        ]
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

        return String(cityCountryPairArray[0]).uppercased()
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
    let id: String
    let tripName: String
    let location: String
    let budget: String?
    let startDate: Date
    let endDate: Date
    let imageString: String?
    
    enum CodingKeys: String, CodingKey {
            case id
            case tripName = "title"
            case location
            case budget
            case startDate = "start_date"   
            case endDate = "end_date"
            case imageString = "cover_image"
        }
}
