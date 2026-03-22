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
}

extension Event {
    static let example = [
        Event(title: "Check-in at Hotel", description: "The Thousand Kyoto", date: .now, startTime: .now, endTime: .now + 2),
        Event(title: "Fushimi Inari Ward", description: "Fushimi Ward, Kyoto", date: .now, startTime: .now, endTime: .now + 2)
        ]
    
    var startTimeToString: String {
        return startTime.formatted(.dateTime.hour().minute())
    }
    
    var dateToString: String {
        return date.formatted(.dateTime.month().day())
    }
    
    var timeDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .short
        formatter.maximumUnitCount = 2
        
        let timeDifferenceString = formatter.string(from: startTime, to: endTime)
        
        return timeDifferenceString ?? "N/A"
    }
}
