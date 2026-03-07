//
//  Date.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/6/26.
//

import Foundation

extension Trip {
    var dateRangeString: String {
        let formatter = DateIntervalFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter.string(from: startDate, to: endDate)
    }
}


