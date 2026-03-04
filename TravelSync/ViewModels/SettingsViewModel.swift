//
//  SettingsViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//


import Foundation
import Observation
import PhotosUI
import SwiftUI

@Observable
class SettingsViewModel {
    var pushNotificationsIsOn: Bool = false
    var emailNotificationsIsOn: Bool = false
    var darkModeIsOn: Bool = false
    
    var fullName: String = ""
    var emailAddress: String = ""
    var phoneNumber: String = ""
    var location: String = ""
    
    // Holds the selection from the picker
    var selectedItem: PhotosPickerItem? = nil
    // Holds the actual image to display
    var profileUIImage: UIImage? = nil
    
    var displayImage: Image {
        if let uiImage = profileUIImage {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.circle.fill")
        }
    }
}
