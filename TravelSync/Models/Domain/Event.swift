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
    let longitude: Double
    let latitude: Double
    let date: Date
    let startTime: Date
    let endTime: Date
    
    @MainActor
    static let example = [
        Event(id: 1, title: "Shopping Spree", location: "Siam Paragon", longitude: 100.5348, latitude: 13.7461, date: .now, startTime: .now, endTime: .now + 2),
        Event(id: 2, title: "Floating Market", location: "Damnoen Saduak Floating Market", longitude: 99.9577, latitude: 13.5186, date: .now, startTime: .now, endTime: .now + 3)
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
