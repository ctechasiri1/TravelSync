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
                VStack (alignment: .leading){
                    HStack(spacing: 20) {
                        Image(systemName: event.category.imageName)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(
                                        Color.secondaryText.opacity(0.4),
                                        style: StrokeStyle(lineWidth: 0.5)
                                    )
                            )
                        
                        VStack(alignment: .leading) {
                            Text(event.title)
                                .font(.system(size: 20, weight: .semibold))
                            
                            Text(event.location)
                                .font(.system(size: 14))
                                .foregroundStyle(.secondaryText)
                        }
                    }
                    .padding([.horizontal, .top])
                        
                    HStack(alignment: .center) {
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
                            .frame(maxWidth: .infinity)
                            .background(.accentPrimary)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                        
                        Button {

                        } label: {
                            HStack {
                                Image(systemName: "calendar")
                                
                                Text("View Event")
                            }
                            .padding()
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(
                                        Color.secondaryText.opacity(0.2),
                                        style: StrokeStyle(lineWidth: 0.5)
                                    )
                            )
                        }
                    }
                    .padding(.vertical, 10)
                }
                .padding()
                .createCardBackgroud()
                .padding()
            }
        }
    }
}

#Preview {
    EventMapScreen(trip: Trip.example, viewModel: EventMapViewModel())
        .environment(AppState())
}
