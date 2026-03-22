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
                coverImage: UIImage(named: "Temp_Background")
            ),
            Trip(
                tripName: "Eating Pho in Vietnam",
                location: "Saigon, Vietnam",
                budget: "2_000",
                startDate: Calendar.current.date(byAdding: .day, value: -7, to: Date.now) ?? .now,
                endDate: Calendar.current.date(byAdding: .day, value: -5, to: Date.now) ?? .now,
                coverImage: UIImage(named: "Temp_Background")
            ),
            Trip(tripName: "Travel to Taiwan",
                 location: "Taipei, Taiwan",
                 budget: "3_000",
                 startDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now) ?? .now,
                 endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date.now) ?? .now,
                 coverImage: UIImage(named: "Temp_Background")
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
