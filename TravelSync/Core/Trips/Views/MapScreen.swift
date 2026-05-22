//
//  MapScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/20/26.
//

import CoreLocation
import MapKit
import SwiftUI

struct MapScreen: View {
    let trip: Trip
    
    var body: some View {
        Map(initialPosition:
                MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: trip.latitude,
                            longitude: trip.longitude
                        ),
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.5,
                            longitudeDelta: 0.5
                        )))) {
                            Marker("Siam Paragon", coordinate: CLLocationCoordinate2D(latitude: 13.7461, longitude: 100.5348))
                        }
    }
}

#Preview {
    MapScreen(trip: Trip.example)
}
