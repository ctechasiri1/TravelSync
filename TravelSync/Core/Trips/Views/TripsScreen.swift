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
        
        VStack {
            Divider()
            
            CustomSegmentButton(selection: $tripsViewModel.selection,
                                options: TripOption.allCases)
            .padding()
            
            ScrollView {
                if tripsViewModel.isUpcomingTrip {
                    UpcomingTrips(
                        upcomingTrips: tripsViewModel.upcomingTrips
                    )
                        
                    AddTripButton(
                        showPlanNewTrip: $tripsViewModel.showPlanNewTrip
                    )
                    .padding(.top, !tripsViewModel.trips.isEmpty ? 20 : 0)
                } else {
                    PastTrips(pastTrips: tripsViewModel.pastTrips)
                }
                    
                Spacer()
            }
        }
        .refreshable {
            await tripsViewModel.getTrip()
        }
        .setScrollViewBackground()
        .task {
            await tripsViewModel.getTrip()
        }
        .fullScreenCover(isPresented: $tripsViewModel.showPlanNewTrip, content: {
            PlanNewTripScreen()
        })
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("My Trips")
                    .padding()
                    .font(.system(.largeTitle, weight: .bold))
                    .fixedSize(horizontal: true, vertical: false)
            }
            .sharedBackgroundVisibility(.hidden)
            
            ToolbarItem(placement: .topBarTrailing) {
                CircleButton(imageName: "magnifyingglass") { }
            }
        }
    }
}

private struct UpcomingTrips: View {
    let upcomingTrips: [Trip]
    
    var body: some View {
        if !upcomingTrips.isEmpty {
            Text("Next Adventure")
                .sectionTitleStyle()
        }
        
        if let firstUpcomingTrip = upcomingTrips.first {
            TripCard(trip: firstUpcomingTrip, upcomingTrip: true)
        }
        
        if upcomingTrips.count > 1 {
            Text("Future Plans")
                .sectionTitleStyle()
                .padding(.top)
        }
        
        ForEach(upcomingTrips) { trip in
            TripCard(trip: trip, upcomingTrip: true)
                .padding(.bottom, 20)
                .padding(.horizontal, 25)
        }
    }
}

private struct PastTrips: View {
    let pastTrips: [Trip]
    
    var body: some View {
        if !pastTrips.isEmpty {
            Text(pastTrips.count == 1 ? "Recent Adventure" : "Recent Adventure")
                .sectionTitleStyle()
        }
        
        ForEach(pastTrips) { trip in
            TripCard(trip: trip, upcomingTrip: false)
                .padding(.bottom, 20)
                .padding(.horizontal, 25)
        }
    }
}

private struct TripCard: View {
    let trip: Trip
    let upcomingTrip: Bool
    
    var body: some View {
        VStack {
            AsyncImage(url: trip.imageURLString) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } placeholder: {
                ProgressView()
            }
            
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
