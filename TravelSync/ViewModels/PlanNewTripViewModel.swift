//
//  PlanNewTripViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/24/26.
//

import Observation
import Foundation
import PhotosUI
import SwiftUI

@Observable
class PlanNewTripViewModel {
    var pushNotificationsIsOn: Bool = true
    var tripName: String = ""
    var locationName: String = ""
    var startDate: Date = Date()
    var endDate: Date = Date()
    
    // Holds the selection from the picker
    var selectedItem: PhotosPickerItem? = nil
    // Holds the actual image to display
    var profileUIImage: UIImage? = nil
    
    var displayImage: Image {
        if let uiImage = profileUIImage {
            return Image(uiImage: uiImage)
        } else {
            return Image("Temp_Background")
        }
    }
}
