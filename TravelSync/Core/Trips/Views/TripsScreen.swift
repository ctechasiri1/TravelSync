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
                .padding(.horizontal)
                
        }
        
        if upcomingTrips.count > 1 {
            Text("Future Plans")
                .sectionTitleStyle()
                .padding(.top)
        }
        
        ForEach(upcomingTrips.dropFirst()) { trip in
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
                    .frame(width: 350, height: 400)
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } placeholder: {
                ZStack {
                    Color.gray.opacity(0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    ProgressView()
                        .frame(width: 300, height: 400)
                }
            }
            .overlay(alignment: .center) {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "clock.fill")
                        
                        Text("\(trip.dateDiffernce ?? "0")")
                    }
                    .font(.system(.subheadline, weight: .semibold))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .background(.accentPrimary)
                    .clipShape(Capsule())
                    .padding(5)
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("\(trip.city),")
                                    .font(.system(.title, weight: .bold))
                                
                                Text("\(trip.country)")
                                    .font(.system(.title, weight: .bold))
                            }
                            .foregroundStyle(.white)
                            .padding(10)
                            
                            HStack {
                                Group {
                                    Image(systemName: "calendar")
                                        .font(.system(.subheadline))
                                    
                                    Text(trip.dateRangeString)
                                }
                                .foregroundStyle(.gray.opacity(0.6))
                                
                                Spacer()
                                
                                DetailsButton {
                                    TripScreen(trip: trip, upcomingTrip: upcomingTrip)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

private struct DetailsButton<T: View>: View {
    @ViewBuilder let content: T
    
    var body: some View {
        NavigationLink {
            content
        } label: {
            HStack {
                Text("Detail")
                
                Image(systemName: "arrow.right")
            }
            .font(.system(.subheadline, weight: .semibold))
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
        }
        .background(.white)
        .clipShape(Capsule())
        .foregroundColor(.primaryText)
        
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
