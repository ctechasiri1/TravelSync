//
//  AppState+EXT.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/30/26.
//

import Foundation

extension AppState {
    var loadingManager: LoadingManager {
        managers.loadingManager
    }
    
    var deleteConfirmationManager: DeleteConfirmationManager {
        managers.deleteConfirmationManager
    }
}
