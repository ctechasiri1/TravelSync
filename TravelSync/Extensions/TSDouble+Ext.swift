//
//  TSDouble+Ext.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/13/26.
//

import Foundation

extension Double {
    /// Formats the Double as a String with exactly two decimal places
    ///```
    /// Convert 3.14159 to "3.14"
    ///```
    var toTwoDecimalPlaces: String {
        return String(format: "%.2f", self)
    }
    
    /// Multiplies the Double by 100 and formats it as a String with one decimal place
    ///```
    /// Convert 0.4567 to "45.7"
    ///```
    var toPercentage: String {
        return String(format: "%.1f", self * 100)
    }
}
