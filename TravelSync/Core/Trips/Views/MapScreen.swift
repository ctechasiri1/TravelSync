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
    @Environment(AppState.self) private var appState
    let trip: Trip
    @State private var position: MapCameraPosition = .automatic
    @State private var markers: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 13.7461, longitude: 100.5348)
    ]

    var body: some View {
        Map(position: $position) {
            ForEach(markers, id: \.latitude) { coord in
                Marker("Siam Paragon", coordinate: coord)
            }
        }
        .ignoresSafeArea()
        .overlay {
            VStack { }
        }
        .onDisappear {
            position = .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
            ))
            markers.removeAll()
            position = .automatic
        }
        .onAppear {
            position = .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: trip.latitude,
                    longitude: trip.longitude
                ),
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            ))
        }
    }
}

#Preview {
    MapScreen(trip: Trip.example)
        .environment(AppState())
}
