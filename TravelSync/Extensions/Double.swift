//
//  Double.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/13/26.
//

import Foundation

extension Double {
    nonisolated var toString: String {
        return String(format: "%.2f", self)
    }
    
    var toPercentage: String {
        return String(format: "%.1f", self * 100)
    }
}
