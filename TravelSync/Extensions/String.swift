//
//  String.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/7/26.
//

import Foundation

extension String {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter
    }()
    
    /// Converts an ISO-formatted String from the server into a Swift Date
    ///```
    /// Convert "2026-04-02T05:13:00" to a Date object
    ///```
    var stringToDate: Date {
        guard let date = String.dateFormatter.date(from: self) else {
            print("There was an issue converting ISO-formatted date to swift")
            return .now
        }
        return date
    }
}
