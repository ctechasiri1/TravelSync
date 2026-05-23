//
//  WeatherManager.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/22/26.
//

import MapKit
import Observation
import WeatherKit

@Observable
final class WeatherManager {
    private let service = WeatherService.shared
    
    func fetch(for location: CLLocation) async throws -> String {
        do {
            let weather = try await service.weather(for: location)
            let currTemp = weather.currentWeather.temperature
            
            return currTemp.value.toString
        } catch {
            throw APIError.invalidPayload
        }
    }
}
