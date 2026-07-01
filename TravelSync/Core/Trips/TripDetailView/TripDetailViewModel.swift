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
    var showDeleteAlert: Bool = false
    var temperature: String = "0"
    var weatherIconName: String = "sun.max.trianglebadge.exclamationmark.fill"
    
    private let tripService: TripServiceProtocol
    // TODO: i need to fix this injection
    private let loadingManager: LoadingManager
    private let weatherKitService: WeatherKitService
    
    init(
        tripService: TripServiceProtocol,
        loadingManager: LoadingManager,
        weatherKitService: WeatherKitService
    ) {
        self.tripService = tripService
        self.loadingManager = loadingManager
        self.weatherKitService = weatherKitService
    }
    
    func getWeather(longitude: Double, latitude: Double) async {
        defer { loadingManager.hide() }
        
        loadingManager.show()
        let coordinates = CLLocation(latitude: latitude, longitude: longitude)
        do {
            let weatherPayload = try await weatherKitService.fetch(
                for: coordinates
            )
            temperature = weatherPayload.0
            weatherIconName = weatherPayload.1
        } catch let error as APIError {
            print("There was a network error: \(error).")
        } catch {
            print("There was an unexpected error.")
        }
    }
    
    func deleteTrip(tripId: Int) async -> Void {
        defer { loadingManager.hide() }
        
        loadingManager.show()
        
        do {
            let _ = try await (
                Task.sleep(nanoseconds: 500_000_000),
                tripService.deleteTrip(tripId: tripId)
            )
        } catch let error as APIError {
            print("There was a network error: \(error).")
        } catch {
            print("There was an unexpected error.")
        }
    }
}
