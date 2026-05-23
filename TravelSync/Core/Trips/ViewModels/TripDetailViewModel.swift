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
    
    private let tripService: TripServiceProtocol
    private let weatherManager: WeatherManager
    
    init(tripService: TripServiceProtocol, weatherManager: WeatherManager) {
        self.tripService = tripService
        self.weatherManager = weatherManager
    }
    
    func getWeather(longitude: Double, latitude: Double) async {
        let coordinates = CLLocation(latitude: latitude, longitude: longitude)
        do {
            temperature = try await weatherManager.fetch(for: coordinates)
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
