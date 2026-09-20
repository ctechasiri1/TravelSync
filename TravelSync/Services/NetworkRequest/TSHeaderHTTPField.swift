//
//  TSHeaderHTTPField.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/19/26.
//


enum TSHeaderHTTPField: String {
    case contentType
    
    var value: String {
        switch self {
        case .contentType:
            "Content-Type"
        }
    }
}
