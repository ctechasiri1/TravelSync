//
//  ServiceContainer.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/15/26.
//

import MapKit
import Foundation

final class ServiceContainer {
    let networkService: TSNetworkRequestService
    let keychainService: KeychainService
    let weatherKitService: WeatherKitService
    
    init(
        networkService: TSNetworkRequestService = TSNetworkRequestService(),
        keychainService: KeychainService = KeychainService(),
        weatherKitService: WeatherKitService = WeatherKitService()
    ) {
        self.networkService = networkService
        self.keychainService = keychainService
        self.weatherKitService = weatherKitService
    }
}
