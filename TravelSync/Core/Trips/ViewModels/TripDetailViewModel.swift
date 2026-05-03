//
//  TripDetailViewMode.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/3/26.
//

import Observation
import Foundation

@Observable
class TripDetailViewModel {
    var enableDeleteAlert: Bool = false
    var isNetworkActive: Bool = false
    
    private let tripService: TripServiceProtocol
    
    init(tripService: TripServiceProtocol) {
        self.tripService = tripService
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
