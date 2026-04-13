//
//  TripsFeedScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/31/25.
//

import SwiftUI

struct TripsFeedScreen: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        @Bindable var tripsFeedViewModel = appState.tripsFeed
        
        VStack {
            CustomSegmentButton(
                selection: $tripsFeedViewModel.selection,
                options: TripOption.allCases
            )
            .padding()
            
            ScrollView {
                Group {
                    if tripsFeedViewModel.trips.isEmpty {
                        VStack {
                            Image("home_image")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 250, height: 150)
                                .clipped()
                        
                            VStack {
                                Text("Where to next?")
                                    .font(.system(.largeTitle, weight: .bold))
                            
                                Text(
                                    "Your travel adventure starts here. Plan your first trip to see it listed."
                                )
                                .foregroundStyle(.secondaryText)
                                .font(.system(.subheadline, weight: .light))
                                .multilineTextAlignment(.center)
                                .frame(width: 200)
                            }
                            .padding()
                        
                            AddTripButton(
                                showPlanNewTrip: $tripsFeedViewModel.showPlanNewTrip
                            )
                            .padding()
                        }
                        .padding(.top, 80)
                    } else {
                        Group {
                            if tripsFeedViewModel.isUpcomingTrip {
                                UpcomingTrips(
                                    showPlanNewTrip: $tripsFeedViewModel.showPlanNewTrip,
                                    upcomingTrips: tripsFeedViewModel.upcomingTrips
                                )
                            } else {
                                PastTrips(
                                    pastTrips: tripsFeedViewModel.pastTrips
                                )
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .setScrollViewBackground()
        .refreshable {
             await tripsFeedViewModel.getTrip()
         }
        .task {
            await tripsFeedViewModel.getTrip()
        }
        .fullScreenCover(isPresented: $tripsFeedViewModel.showPlanNewTrip, content: {
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
                    tripsFeedViewModel.showPlanNewTrip = true
                }
            }
            .sharedBackgroundVisibility(.hidden)
        }
    }
}

private struct UpcomingTrips: View {
    @Binding var showPlanNewTrip: Bool
    let upcomingTrips: [Trip]
    
    var body: some View {
        if !upcomingTrips.isEmpty {
            Text("Next Adventure")
                .sectionTitleStyle()
                .padding(.leading, 20)
            
            if let firstUpcomingTrip = upcomingTrips.first {
                TripCard(trip: firstUpcomingTrip, height: 400, upcomingTrip: true)
                    .padding(.horizontal)
            }
            
            if upcomingTrips.count > 1 {
                Text("Future Plans")
                    .sectionTitleStyle()
                    .padding(.top)
            }
            
            ForEach(upcomingTrips.dropFirst()) { trip in
                TripCard(trip: trip, height: 250, upcomingTrip: true)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 25)
            }
        } else {
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
                    showPlanNewTrip: $showPlanNewTrip
                )
                .padding()
            }
            .padding(.top, 80)
        }
    }
}

private struct PastTrips: View {
    let pastTrips: [Trip]
    
    var body: some View {
        if !pastTrips.isEmpty {
            Text(pastTrips.count == 1 ? "Recent Adventure" : "Recent Adventures")
                .sectionTitleStyle()
                .padding(.leading, 20)
            
            ForEach(pastTrips) { trip in
                TripCard(trip: trip, height: 300, upcomingTrip: false)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 25)
            }
        } else {
            VStack {
                Image("past_image")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipped()
                
                VStack {
                    Text("No past trips yet")
                        .font(.system(.largeTitle, weight: .bold))
                    
                    Text("Your completed adventures and travel memories will appear here.")
                        .foregroundStyle(.secondaryText)
                        .font(.system(.subheadline, weight: .light))
                        .multilineTextAlignment(.center)
                        .frame(width: 200)
                }
                .padding()
            }
            .padding(.top, 80)
        }
    }
}

private struct TripCard: View {
    let trip: Trip
    let height: CGFloat
    let upcomingTrip: Bool
    let isFavorite: Bool = false
    
    var body: some View {
        VStack {
            AsyncImage(url: trip.imageURLString) { image in
                image
                    .resizable()
                    .frame(height: height)
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } placeholder: {
                ZStack {
                    Color.gray.opacity(0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    ProgressView()
                        .frame(height: height)
                }
            }
            .overlay(alignment: .center) {
                VStack(alignment: .leading) {
                    HStack {
                        HStack {
                            Image(systemName: "clock.fill")
                            
                            Text(trip.dateDifference)
                        }
                        .font(.system(.subheadline, weight: .semibold))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .foregroundColor(.white)
                        .background(.accentPrimary)
                        .clipShape(Capsule())
                        .padding(5)
                        
                        Spacer()
                        
                        CircleIcon(
                            iconName: isFavorite ? "heart.fill" : "heart",
                            iconColor: .pink,
                            width: 10,
                            height: 10
                        )
                        .padding(.horizontal)
                    }
                    
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
                                .foregroundStyle(.white)
                                
                                Spacer()
                                
                                DetailsButton {
                                    TripDetailScreen(trip: trip, upcomingTrip: upcomingTrip)
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
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(Color.accentPrimary))
            )
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    TripsFeedScreen()
        .environment(AppState())
}
