//
//  TripPrivateResponse.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/13/26.
//

import Foundation

struct TripResponse: nonisolated Codable, Sendable {
    let id: Int
    let tripName: String
    let location: String
    let longitude: Double
    let latitude: Double
    let totalSpending: Int
    let budget: Int
    let isFavorite: Bool
    let startDateString: String
    let endDateString: String
    let imageURLString: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case tripName = "title"
        case location
        case longitude
        case latitude
        case totalSpending = "total_spending"
        case budget
        case isFavorite = "is_favorite"
        case startDateString = "start_date"
        case endDateString = "end_date"
        case imageURLString = "cover_image_url"
        }
    
    static var mock: TripResponse {
        return TripResponse.mocks[0]
    }
    
    static var mocks: [TripResponse] {
        return [
            TripResponse(
                id: 1,
                tripName: "Mango Sticky Rice Summer",
                location: "Bangkok, Thailand",
                longitude: 13.7563,
                latitude: 100.5018,
                totalSpending: 30,
                budget: 5000,
                isFavorite: true,
                startDateString: "2026-07-20T00:00:00Z",
                endDateString: "2026-07-23T00:00:00Z",
                imageURLString: ""
            ),
            TripResponse(
                id: 2,
                tripName: "Tokyo Adventure",
                location: "Tokyo, Japan",
                longitude: 139.6917,
                latitude: 35.6895,
                totalSpending: 2450,
                budget: 3000,
                isFavorite: true,
                startDateString: "2026-06-03T00:00:00Z",
                endDateString: "2026-06-10T00:00:00Z",
                imageURLString: ""
            ),
            TripResponse(
                    id: 3,
                    tripName: "Parisian Getaway",
                    location: "Paris, France",
                    longitude: 2.3522,
                    latitude: 48.8566,
                    totalSpending: 1800,
                    budget: 2200,
                    isFavorite: false,
                    startDateString: "2026-05-12T00:00:00Z",
                    endDateString: "2026-05-19T00:00:00Z",
                    imageURLString: ""
            ),
            TripResponse(
                 id: 5,
                 tripName: "Swiss Alps Hiking Trip",
                 location: "Interlaken, Switzerland",
                 longitude: 7.8632,
                 latitude: 46.6863,
                 totalSpending: 2100,
                 budget: 2500,
                 isFavorite: true,
                 startDateString: "2026-02-05T00:00:00Z",
                 endDateString: "2026-02-14T00:00:00Z",
                 imageURLString: ""
             )
        ]
    }
}

extension TripResponse {
    var startDate: Date {
        return startDateString.stringToDate
    }
    
    var endDate: Date {
        return endDateString.stringToDate
    }
    
    var imageURL: URL? {
        return URL(string: imageURLString) ?? nil
    }
}
