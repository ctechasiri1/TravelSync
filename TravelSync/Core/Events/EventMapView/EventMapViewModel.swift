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
    var events: [Event] = Event.example
    var selectedEvent: Event? = nil
    
    func openInMaps(latitude: Double, longitude: Double, name: String) {
        let coordinate = CLLocation(latitude: latitude, longitude: longitude)
        let mapItem = MKMapItem(location: coordinate, address: nil)
        mapItem.name = name
        mapItem.openInMaps()
    }
    
    func findNextLocation(currentEvent: Event) {
        let eventsCount = events.count
        for (index, event) in events.enumerated() {
            if event == currentEvent {
                selectedEvent = events[(index + 1) % eventsCount]
            }
        }
    }
    
    func findPrevLocation(currentEvent: Event) {
        let eventsCount = events.count
        for (index, event) in events.enumerated() {
            if event == currentEvent {
                selectedEvent = events[abs(index - 1) % eventsCount]
            }
        }
    }
    
    func updateSelectedEvent(newEvent: Event?) {
        if let latitude = newEvent?.latitude, let longitude = newEvent?.longitude {
            position = .region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: latitude,
                        longitude: longitude
                    ),
                    latitudinalMeters: 10000,
                    longitudinalMeters: 10000)
            )
        }
    }
}
