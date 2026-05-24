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
    
    init(locationSearchManager: LocationSearchManager = LocationSearchManager(completer: MKLocalSearchCompleter())) {
        self.locationSearchManager = locationSearchManager
    }
}
