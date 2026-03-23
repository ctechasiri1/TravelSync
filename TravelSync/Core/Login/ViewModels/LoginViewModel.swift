//
//  LoginViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/22/26.
//

import Observation
import Foundation

@Observable
class LoginViewModel {
    // For Login Screen
    var email: String = ""
    var password: String = ""
    
    // For Loading Screen
    var loadingValue: Float = 0
    var loadingTimer: Timer?
    var navigateToLoginScreen: Bool = false
    
    func startLoading() {
        loadingTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.loadingValue += 10
            print("Loading: \(self.loadingValue)")
            
            if self.loadingValue > 100 {
                self.navigateToLoginScreen = true
                timer.invalidate()
                print("Loading Finished")
            }
        })
    }
    
}
