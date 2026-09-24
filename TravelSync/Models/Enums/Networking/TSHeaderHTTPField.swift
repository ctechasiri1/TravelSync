//
//  TSHeaderHTTPField.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/19/26.
//

import Foundation

enum TSHeaderHTTPField: String {
    case contentType
    
    var value: String {
        switch self {
        case .contentType:
            "Content-Type"
        }
    }
}
