//
//  TSServiceContainer.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/15/26.
//

import MapKit
import Foundation

@MainActor
struct TSServiceContainer {
    
    let keychainService: TSKeychainService
    let weatherKitService: TSWeatherKitService
    
    let userAuthService: TSUserAuthService
    
    static func live() -> TSServiceContainer {
        let keychainService = TSKeychainService()
        let weatherKitService = TSWeatherKitService()
        let networkService = TSNetworkRequestService()
        return TSServiceContainer(
            keychainService: keychainService,
            weatherKitService: weatherKitService,
            userAuthService: TSLiveUserAuthService(networkService: networkService)
        )
    }
    
    static func mock() -> TSServiceContainer {
        let keychainService = TSKeychainService()
        let weatherKitService = TSWeatherKitService()
        return TSServiceContainer(
            keychainService: keychainService,
            weatherKitService: weatherKitService,
            userAuthService: TSMockUserAuthService()
        )
    }
}
