//
//  TSHTTPMethod.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 9/19/26.
//

import Foundation

enum TSHTTPMethod: String {
    case get, post, patch, delete
    
    var value: String {
        switch self {
        case .get:
            "GET"
        case .post:
            "POST"
        case .patch:
            "PATCH"
        case .delete:
            "DELETE"
        }
    }
}
