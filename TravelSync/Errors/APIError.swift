//
//  APIError.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/23/26.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case encoding(Error)
    case decoding(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .invalidResponse:
            return "Invalid response from server."
        case .encoding(let error):
            return "Failed to encode response: \(error.localizedDescription)"
        case .decoding(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}
