//
//  TripDetailViewMode.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/3/26.
//

import MapKit
import Observation
import Foundation
import WeatherKit

@Observable
class TripDetailViewModel {
    var enableDeleteAlert: Bool = false
    var isNetworkActive: Bool = false
    var temperature: String = "0"
    var weatherIconName: String = "sun.max.trianglebadge.exclamationmark.fill"
    
    private let tripService: TripServiceProtocol
    private let weatherKitService: WeatherKitService
    
    init(tripService: TripServiceProtocol, weatherKitService: WeatherKitService) {
        self.tripService = tripService
        self.weatherKitService = weatherKitService
    }
    
    func getWeather(longitude: Double, latitude: Double) async {
        defer { isNetworkActive = false }
        
        isNetworkActive = true
        let coordinates = CLLocation(latitude: latitude, longitude: longitude)
        do {
            let weatherPayload = try await weatherKitService.fetch(for: coordinates)
            temperature = weatherPayload.0
            weatherIconName = weatherPayload.1
        } catch let error as APIError {
            print("There was a network error: \(error).")
        } catch {
            print("There was an unexpected error.")
        }
    }
    
    func deleteTrip(tripId: Int) async -> Void {
        defer { isNetworkActive = false }
        
        isNetworkActive = true
        
        do {
            let _ = try await (Task.sleep(nanoseconds: 500_000_000), tripService.deleteTrip(tripId: tripId))
        } catch let error as APIError {
            print("There was a network error: \(error).")
        } catch {
            print("There was an unexpected error.")
        }
    }
}
