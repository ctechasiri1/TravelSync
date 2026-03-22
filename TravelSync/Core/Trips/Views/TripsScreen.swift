//
//  TripsScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/31/25.
//

import SwiftUI

struct TripsScreen: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        @Bindable var tripsViewModel = appState.trips
        
        NavigationStack {
            ScrollView {
                Divider()
                
                CustomSegmentButton(selection: $tripsViewModel.selection,
                                    options: TripOption.allCases)
                .padding()
                
                if !tripsViewModel.trips.isEmpty {
                    Text("Next Adventure")
                        .sectionTitleStyle()
                }
                
                if let firstTrip = tripsViewModel.trips.first {
                    TripCard(trip: firstTrip, upcomingTrip: true)
                        .padding(.horizontal)
                }
                
                if tripsViewModel.trips.count > 1 {
                    Text("Future Plans")
                        .sectionTitleStyle()
                }

                ForEach(tripsViewModel.trips.dropFirst()) { trip in
                    TripCard(trip: trip, upcomingTrip: false)
                        .padding(5)
                }

                AddTripButton(showPlanNewTrip: $tripsViewModel.showPlanNewTrip)
                    .padding(.top, !tripsViewModel.trips.isEmpty ? 20 : 0)
                
                Spacer()
            }
            .setScrollViewBackground()
            .fullScreenCover(isPresented: $tripsViewModel.showPlanNewTrip, content: {
                PlanNewTripScreen()
            })
            .navigationTitle(Text("My Trips"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CircleButton(imageName: "magnifyingglass") { }
                }
            }
        }
    }
}

private struct TripCard: View {
    let trip: Trip
    let upcomingTrip: Bool
    
    var body: some View {
        VStack {
            Group {
                if let image = trip.coverImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image("Temp_Background")
                        .resizable()
                        .scaledToFit()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(trip.location)
                            .font(.system(.title, weight: .bold))
                        
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundStyle(Color.accentBlue)
                            Text(trip.dateRangeString)
                                .foregroundStyle(Color.secondaryText)
                        }
                    }
                    
                    Spacer()
                    
                    CircleIcon(iconName: "airplane.departure", iconColor: Color.accentBlue, width: 50, height: 50)
                }
                .padding()
                
                Divider()
                
                HStack {
                    Image(systemName: "circle.fill")
                    
                    Spacer()
                    
                    NavigationLink {
                        TripScreen(trip: trip, upcomingTrip: upcomingTrip)
                    } label: {
                        Text("View Itinerary")
                    }

                    Image(systemName: "arrow.forward")
                }
                .bold()
                .foregroundStyle(Color.accentBlue)
                .padding()
            }
            .padding()
        }
        .createCardBackgroud()
    }
}

private struct AddTripButton: View {
    @Binding var showPlanNewTrip: Bool
    
    var body: some View {
        Button {
            showPlanNewTrip = true
        } label: {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(Color(.systemBlue))
                
                Text("Plan a new trip")
                    .font(.system(size: 18, weight: .semibold, design: .default))
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(Color.accentBlue.opacity(0.05)))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        Color.blue.opacity(0.2),
                        style: StrokeStyle(lineWidth: 2, dash: [10, 5])
                    )
            )
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    TripsScreen()
        .environment(AppState())
}
