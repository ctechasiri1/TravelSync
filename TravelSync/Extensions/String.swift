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
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        return formatter
    }()
    
    /// Converts an ISO-formatted String from the server into a Swift Date
    ///```
    /// Convert "2026-04-02T05:13:00" to a native Date object
    ///```
    var stringToDate: Date {
        let date = String.dateFormatter.date(from: self)
        return date ?? .now
    }
}
