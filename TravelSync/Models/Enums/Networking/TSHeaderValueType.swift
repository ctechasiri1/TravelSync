//
//  TSHeaderValueType.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/19/26.
//

import Foundation

enum TSHeaderValueType: String {
    case applicationJson, formUrlencoded
    
    var value: String {
        switch self {
        case .applicationJson:
            "application/json"
        case .formUrlencoded:
            "application/x-www-form-urlencoded"
        }
    }
}
