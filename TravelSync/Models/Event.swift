//
//  Event.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/21/26.
//

import Foundation

struct Event: Identifiable {    
    let id: UUID = UUID()
    let title: String
    let description: String
    let date: Date
    let startTime: Date
    let endTime: Date
    
    @MainActor
    static let example = [
        Event(title: "Check-in at Hotel", description: "The Thousand Kyoto", date: .now, startTime: .now, endTime: .now + 2),
        Event(title: "Fushimi Inari Ward", description: "Fushimi Ward, Kyoto", date: .now, startTime: .now, endTime: .now + 2)
        ]
}

extension Event {
    var startTimeToString: String {
        return startTime.dateToStringHourAndMin
    }
    
    var dateToString: String {
        return date.dateToStringMonthAndDay
    }
    
    var timeDuration: String {
        return startTime.durationString(to: endTime)
    }
}
