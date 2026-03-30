//
//  Data.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/29/26.
//

import Foundation

extension Data {
    /// convert  string to raw bytes
    mutating func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
