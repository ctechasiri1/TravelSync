//
//  APIKeys.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/19/26.
//

import Foundation

enum APIKeys {
    static var googlePlaces: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_PLACES_API_KEY") as? String,
              !key.isEmpty else {
            fatalError("Google Places API key missing — check Secrets.xcconfig and Info.plist")
        }
        return key
    }
}
