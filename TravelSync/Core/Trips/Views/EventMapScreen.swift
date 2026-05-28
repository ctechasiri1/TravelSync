//
//  EventMapScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/20/26.
//

import CoreLocation
import MapKit
import SwiftUI

struct EventMapScreen: View {
    @Environment(AppState.self) private var appState
    let trip: Trip
    
    @State private var viewModel: EventMapViewModel
    
    init(trip: Trip, viewModel: EventMapViewModel) {
        self.trip = trip
        _viewModel = State(wrappedValue: viewModel)
    }


    var body: some View {
        Map(position: $viewModel.position, selection: $viewModel.selectedEvent) {
            ForEach(viewModel.locations, id: \.self) { event in
                Marker(event.location, coordinate: CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude))
            }
        }
        .ignoresSafeArea()
        .overlay(alignment: .bottom) {
            if let event = viewModel.selectedEvent {
                VStack {
                    Text(event.title)
                        
                    Text(event.location)
                        
                    HStack {
                        Button {
                            viewModel
                                .openInMaps(
                                    latitude: event.latitude,
                                    longitude: event.longitude,
                                    name: event.location
                                )
                        } label: {
                            HStack {
                                Image(systemName: "arrow.triangle.turn.up.right.circle")
                                
                                Text("Directions")
                            }
                            .padding()
                            .foregroundStyle(.white)
                            .background(.accentPrimary)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        
                        Button {

                        } label: {
                            Text("Open in maps")
                                .padding()
                                .foregroundStyle(.black)
                                .background(.accentPrimary)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                }
                .padding()
                .createCardBackgroud()
                .padding()
            }
        }
    }
}

//#Preview {
//    MapScreen(trip: Trip.example)
//        .environment(AppState())
//}
