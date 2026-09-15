//
//  AppState+Ext.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/30/26.
//

import Foundation

extension TSAppState {    
    var deleteConfirmationManager: DeleteConfirmationManager {
        managers.deleteConfirmationManager
    }
}
