//
//  Event.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/21/26.
//

import Foundation

struct Event: Identifiable, Hashable {    
    let id: Int
    let title: String
    let location: String
    let category: EventOption
    let longitude: Double
    let latitude: Double
    let date: Date
    let startTime: Date
    let endTime: Date
    let notes: String
    
    @MainActor
    static let example = [
        Event(id: 1, title: "Shopping Spree", location: "Siam Paragon", category: .sightseeing, longitude: 100.5348, latitude: 13.7461, date: .now, startTime: .now, endTime: .now + 2, notes: "Siam Paragon is one of Thailand's largest and most luxurious shopping destinations."),
        Event(id: 2, title: "Floating Market", location: "Damnoen Saduak Floating Market", category: .sightseeing, longitude: 99.9577, latitude: 13.5186, date: .now, startTime: .now, endTime: .now + 3, notes: "Located in Ratchburi Province, about 100 km southwest of Bangkok, Damnoen Saduak is Thailand's most famous and iconic floasting market.")
        ]
}

extension Event {
    var startTimeToString: String {
        return startTime.formattedTime
    }
    
    var dateToString: String {
        return date.formattedMonthDay
    }
    
    var timeDuration: String {
        return startTime.formattedDuration(to: endTime)
    }
}
