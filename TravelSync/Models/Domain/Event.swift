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
    let date: Date
    let startTime: Date
    let endTime: Date
    
    @MainActor
    static let example = [
        Event(id: 1, title: "Check-in at Hotel", location: "The Thousand Kyoto", date: .now, startTime: .now, endTime: .now + 2),
        Event(id: 2, title: "Fushimi Inari Ward", location: "Fushimi Ward, Kyoto", date: .now, startTime: .now, endTime: .now + 2)
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
