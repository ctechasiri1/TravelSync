//
//  Search.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/22/26.
//

import MapKit
import Foundation

struct SearchCompletions: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
}

struct SearchResult: Identifiable, Hashable {
    let id = UUID()
    let location: CLLocationCoordinate2D
    
    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
