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
            CustomSegmentButton(
                selection: $tripsViewModel.selection,
                options: TripOption.allCases
            )
            .padding()
            
            ScrollView {
                if tripsViewModel.trips.isEmpty {
                    VStack {
                        Image("home_image")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 250, height: 150)
                            .clipped()
                        
                        VStack {
                            Text("Where to next?")
                                .font(.system(.largeTitle, weight: .bold))
                            
                            Text("Your travel adventure starts here. Plan your first trip to see if listed.")
                                .foregroundStyle(.secondaryText)
                                .font(.system(.subheadline, weight: .light))
                                .multilineTextAlignment(.center)
                                .frame(width: 200)
                        }
                        .padding()
                        
                        AddTripButton(
                            showPlanNewTrip: $tripsViewModel.showPlanNewTrip
                        )
                        .padding()
                    }
                    .padding(.top, 80)
                } else {
                    Group {
                        if tripsViewModel.isUpcomingTrip {
                            UpcomingTrips(
                                upcomingTrips: tripsViewModel.upcomingTrips
                            )
                        } else {
                            PastTrips(pastTrips: tripsViewModel.pastTrips)
                        }
                    }
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
                    .font(.system(.largeTitle, weight: .bold))
                    .fixedSize(horizontal: true, vertical: false)
            }
            .sharedBackgroundVisibility(.hidden)
            
            ToolbarItem(placement: .topBarTrailing) {
                ToolbarButton(imageName: "plus", foregroundColor: .white, backgroundColor: .accentPrimary) {
                    tripsViewModel.showPlanNewTrip = true
                }
            }
            .sharedBackgroundVisibility(.hidden)
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
            .foregroundStyle(.white)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(Color.accentPrimary))
            )
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    TripsScreen()
        .environment(AppState())
}
