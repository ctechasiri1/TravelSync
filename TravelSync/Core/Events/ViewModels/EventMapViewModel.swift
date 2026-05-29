//
//  EventMapViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/27/26.
//

import Observation
import _MapKit_SwiftUI
import Foundation

@Observable
class EventMapViewModel {
    var position: MapCameraPosition = .automatic
    var locations: [Event] = Event.example
    var selectedEvent: Event? = nil
    
    func openInMaps(latitude: Double, longitude: Double, name: String) {
        let coordinate = CLLocation(latitude: latitude, longitude: longitude)
        let mapItem = MKMapItem(location: coordinate, address: nil)
        mapItem.name = name
        mapItem.openInMaps()
    }
}
