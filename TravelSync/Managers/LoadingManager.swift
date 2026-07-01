//
//  LoadingManager.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/30/26.
//

import Observation
import Foundation

@MainActor
@Observable
class LoadingManager {
    var isLoading = false
    
    func show() {
        self.isLoading = true
    }
    
    func hide() {
        self.isLoading = false
    }
}
