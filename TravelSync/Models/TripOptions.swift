//
//  TripOption.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/31/25.
//

import Foundation

enum TripOption: CaseIterable {
    case upcoming
    case past
    
    var title: String {
        switch self {
        case .upcoming: return "Upcoming"
        case .past: return "Past"
        }
    }
}
