//
//  EventOption.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/28/26.
//

import Foundation

enum EventOption: String, CaseIterable {
    case dinning, stay, sightseeing, transport
    
    var title: String {
        switch self {
        case .dinning:
            "Resturant"
        case .stay:
            "Stay"
        case .sightseeing:
            "Sights"
        case .transport:
            "Transport"
        }
    }
    
    var imageName: String {
        switch self {
        case .dinning:
            "fork.knife"
        case .stay:
            "bed.double"
        case .sightseeing:
            "mountain.2"
        case .transport:
            "car.fill"
        }
    }
}
