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
    let weatherManager: WeatherManager
    
    init(locationSearchManager: LocationSearchManager = LocationSearchManager(completer: MKLocalSearchCompleter()), weatherManger: WeatherManager = WeatherManager()) {
        self.locationSearchManager = locationSearchManager
        self.weatherManager = weatherManger
    }
}
