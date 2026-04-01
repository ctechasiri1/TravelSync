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
        
        ScrollView {
            Divider()
                
            CustomSegmentButton(selection: $tripsViewModel.selection,
                                options: TripOption.allCases)
            .padding()
                
            if !tripsViewModel.upcomingTrips.isEmpty {
                Text(
                    tripsViewModel.isUpcomingTrip ? "Next Adventure" : "Recent Adventure"
                )
                .sectionTitleStyle()
            }
                
            if let firstTripUpcoming = tripsViewModel.upcomingTrips.first,
               let firstTripPast = tripsViewModel.pastTrips.first {
                TripCard(
                    trip: tripsViewModel.isUpcomingTrip ? firstTripUpcoming : firstTripPast,
                    upcomingTrip: true
                )
                .padding(.horizontal)
            }
                
            if tripsViewModel.isUpcomingTrip ? tripsViewModel.upcomingTrips.count > 1 : tripsViewModel.pastTrips.count > 1 {
                Text(
                    tripsViewModel.isUpcomingTrip ? "Future Plans" : "Past Plans"
                )
                .sectionTitleStyle()
                .padding(.top)
            }

            ForEach(
                tripsViewModel.isUpcomingTrip ? tripsViewModel.upcomingTrips
                    .dropFirst() : tripsViewModel.pastTrips
                    .dropFirst()
            ) { trip in
                TripCard(trip: trip, upcomingTrip: false)
                    .padding(.horizontal, 25)
            }

            if tripsViewModel.isUpcomingTrip {
                AddTripButton(showPlanNewTrip: $tripsViewModel.showPlanNewTrip)
                    .padding(.top, !tripsViewModel.trips.isEmpty ? 20 : 0)
            }
                
            Spacer()
        }
        .task {
            do {
                try await tripsViewModel.getTrip()
            } catch {
                
            }
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

private struct TripCard: View {
    let trip: Trip
    let upcomingTrip: Bool
    
    var body: some View {
        VStack {
            AsyncImage(url: trip.imageURLString)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(trip.location)
                            .font(.system(.title, weight: .bold))
                        
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundStyle(.accentBlue)
                            Text(trip.dateRangeString)
                                .foregroundStyle(Color.secondaryText)
                        }
                    }
                    
                    Spacer()
                    
                    CircleIcon(iconName: "airplane.departure", iconColor: .accentBlue, width: 50, height: 50)
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
                .foregroundStyle(.accentBlue)
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
                
                Text("Plan a new trip")
                    .font(.system(size: 18, weight: .semibold, design: .default))
            }
            .foregroundStyle(Color(.accentBlue))
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(Color.accentBlue.opacity(0.05)))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        Color.accentBlue.opacity(0.2),
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
