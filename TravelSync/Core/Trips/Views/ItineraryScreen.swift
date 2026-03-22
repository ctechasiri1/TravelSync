//
//  ItineraryScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/21/26.
//

import MapKit
import SwiftUI

struct ItineraryScreen: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        @Bindable var currentTripViewModel = appState.currentTrip
        
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Detailed Itinerary")
                        .font(.system(.title3, weight: .semibold))
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    ManageButton{}

                }
                
                Text("APRIL 10, WEDNESDAY")
                    .foregroundStyle(.secondaryText)
                    .font(.system(.subheadline, weight: .semibold))
                    .padding()
                
                DetailedItinerary(events: currentTripViewModel.events)
            }
        }

    }
}

struct ManageButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text("Manage")
                Image(systemName: "arrow.up.right.square")
            }
            .padding(8)
            .foregroundStyle(.secondaryText)
            .font(.system(size: 15, weight: .semibold))
            .background(.gray.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding()
        }
    }
}

struct DetailedItinerary: View {
    let events: [Event]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(events) { event in
                HStack {
                    VStack(alignment: .center) {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.blue)
                        
                        Rectangle()
                            .frame(width: 2)
                            .foregroundColor(.gray)
                    }
                    .frame(height: 140)
                    .padding(.vertical, 5)

                    VStack {
                        Text(event.startTimeToString)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                        
                        OptionsCard(title: "") {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(event.title)
                                        .font(.headline)
                                    
                                    Text(event.description)
                                        .foregroundStyle(.secondaryText)
                                        .font(.subheadline)
                                    
                                    HStack {
                                        Image(systemName: "clock.fill")
                                        Text(event.timeDuration + " duration")
                                    }
                                    .padding(5)
                                    .font(.system(size: 12, weight: .semibold))
                                    .background(.gray.opacity(0.05))
                                    .foregroundStyle(.secondaryText)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                }
                                .padding()
                                
                                Spacer()
                            }
                        }
                    }
                }
                .padding(10)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

#Preview {
    ItineraryScreen()
        .environment(AppState())
}
