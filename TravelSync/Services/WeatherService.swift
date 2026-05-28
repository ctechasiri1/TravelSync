//
//  WeatherManager.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/22/26.
//

import MapKit
import Observation
import WeatherKit

final class WeatherKitService {
    private let service = WeatherService.shared
    
    nonisolated func fetch(for location: CLLocation) async throws -> (String, String) {
        do {
            let weather = try await service.weather(for: location)
            let currTemp = weather.currentWeather.temperature
            let iconName = weather.currentWeather.symbolName
            
            return (currTemp.value.toString, iconName)
        } catch {
            throw APIError.invalidPayload
        }
    }
}
