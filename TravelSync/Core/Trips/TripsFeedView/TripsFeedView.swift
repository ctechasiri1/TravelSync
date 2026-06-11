//
//  TripsFeedView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/31/25.
//

import SwiftUI

struct TripsFeedView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: TripsFeedViewModel
    
    init(viewModel: TripsFeedViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("my_trips")
                    .font(.system(.largeTitle, weight: .bold))
                    .padding()
                        
                Spacer()
                    
                AddButton {
                    viewModel.toggleShowPlanNewTrip()
                }
                .padding(.horizontal, 20)
            }
            
            CustomSegmentButton(
                selection: $viewModel.selection
            )
            .padding(.horizontal)
            
            ScrollView {
                Group {
                    if viewModel.trips.isEmpty {
                        NoTripsView(isUpcomingSelected: viewModel.isUpcomingSelected) {
                            viewModel.toggleShowPlanNewTrip()
                        }
                    } else {
                        Group {
                            if viewModel.isUpcomingSelected {
                                UpcomingTripsView(upcomingTrips: viewModel.upcomingTrips, viewModel: viewModel)
                            } else {
                                PastTripsView(pastTrips: viewModel.pastTrips, viewModel: viewModel)
                            }
                        }
                    }
                }
            }
        }
        .setScrollViewBackground()
        .refreshable {
             await viewModel.getTrip()
         }
        .task {
            await viewModel.getTrip()
        }
        .onChange(of: viewModel.showPlanNewTrip, { oldValue, newValue in
            Task {
                await viewModel.getTrip()
            }
        })
        .fullScreenCover(isPresented: $viewModel.showPlanNewTrip, content: {
            PlanNewTripScreen(viewModel: appState.makePlanNewTripViewModel())
        })
    }
}

private struct NoTripsView: View {
    let isUpcomingSelected: Bool
    let planNewTripToggle: () -> Void
    
    var body: some View {
        VStack {
            Image(isUpcomingSelected ? "home_image" : "past_image")
                .resizable()
                .scaledToFill()
                .frame(width: isUpcomingSelected ? 250 : 150, height: 150)
                .clipped()
        
            VStack {
                Text(isUpcomingSelected ? "empty_trips_title" : "empty_past_trips_title")
                    .font(.system(.largeTitle, weight: .bold))
            
                Text(isUpcomingSelected ? "empty_trips_description" : "empty_past_trips_description")
                    .foregroundStyle(.secondaryText)
                    .font(.system(.subheadline, weight: .light))
                    .multilineTextAlignment(.center)
                    .frame(width: 200)
            }
            .padding()
            
            if isUpcomingSelected {
                AddTripButton {
                    planNewTripToggle()
                }
                .padding()
            }
        }
        .padding(.top, 80)
        
        Spacer()
    }
}

private struct UpcomingTripsView: View {
    let upcomingTrips: [Trip]
    let viewModel: TripsFeedViewModel
    
    var body: some View {
        if !upcomingTrips.isEmpty {
            Text("next_adventure")
                .sectionTitleStyle()
                .padding(.leading, 20)
            
            if let firstUpcomingTrip = upcomingTrips.first {
                TripCardView(
                    trip: firstUpcomingTrip,
                    viewModel: viewModel,
                    height: 350,
                    isUpcomingTrip: true,
                    isFirstUpcomingTrip: true
                )
                .padding(.horizontal, 25)
            }
            
            if upcomingTrips.count > 1 {
                Text("future_plans")
                    .sectionTitleStyle()
                    .padding(.top)
                    .padding(.leading, 20)
            }
            
            ForEach(upcomingTrips.dropFirst()) { trip in
                TripCardView(
                    trip: trip,
                    viewModel: viewModel,
                    height: 250,
                    isUpcomingTrip: true
                )
                    .padding(.bottom, 20)
                    .padding(.horizontal, 25)
            }
        } else {
            NoTripsView(isUpcomingSelected: viewModel.isUpcomingSelected) {
                viewModel.toggleShowPlanNewTrip()
            }
        }
    }
}

private struct PastTripsView: View {
    let pastTrips: [Trip]
    let viewModel: TripsFeedViewModel
    
    var body: some View {
        if !pastTrips.isEmpty {
            Text(pastTrips.count == 1 ? "recent_adventure" : "recent_adventures")
                .sectionTitleStyle()
                .padding(.leading, 20)
            
            ForEach(pastTrips) { trip in
                TripCardView(
                    trip: trip,
                    viewModel: viewModel,
                    height: 300,
                    isUpcomingTrip: false
                )
                    .padding(.bottom, 20)
                    .padding(.horizontal, 25)
            }
        } else {
            NoTripsView(isUpcomingSelected: viewModel.isUpcomingSelected) {
                viewModel.toggleShowPlanNewTrip()
            }
        }
    }
}

private struct AddTripButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: "plus.circle.fill")
                
                Text("plan_new_trip")
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
    TripsFeedView(viewModel: TripsFeedViewModel(tripService: TripService(networkService: NetworkRequestService(), keychainService: KeychainService())))
        .environment(AppState())
}
