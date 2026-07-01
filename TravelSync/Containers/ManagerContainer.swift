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
    let deleteConfirmationManager: DeleteConfirmationManager
    
    init(
        locationSearchManager: LocationSearchManager = LocationSearchManager(
            completer: MKLocalSearchCompleter()
        ),
        loadingManager: LoadingManager = LoadingManager(),
        deleteConfirmationManager: DeleteConfirmationManager = DeleteConfirmationManager()
    ) {
        self.locationSearchManager = locationSearchManager
        self.loadingManager = loadingManager
        self.deleteConfirmationManager = deleteConfirmationManager
    }
}
