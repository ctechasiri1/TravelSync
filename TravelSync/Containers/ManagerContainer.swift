//
//  ManagerContainer.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/22/26.
//

import MapKit
import Foundation

final class ManagerContainer {
    let locationSearchManager: LocationSearchManager
    let loadingManager: LoadingManager
    
    init(locationSearchManager: LocationSearchManager = LocationSearchManager(completer: MKLocalSearchCompleter()), loadingManager: LoadingManager = .shared) {
        self.locationSearchManager = locationSearchManager
        self.loadingManager = loadingManager
    }
}
