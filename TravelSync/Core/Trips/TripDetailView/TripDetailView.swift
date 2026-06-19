//
//  TripDetailView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/7/26.
//

import SwiftUI

struct TripDetailView: View {
    @Binding var trip: Trip
    let isUpcomingTrip: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    @State private var viewModel: TripDetailViewModel
    
    init(
        viewModel: TripDetailViewModel,
        trip: Binding<Trip>,
        isUpcomingTrip: Bool
    ) {
        _viewModel = State(wrappedValue: viewModel)
        _trip = trip
        self.isUpcomingTrip = isUpcomingTrip
    }
    
    var body: some View {
        ScrollView {
            VStack {
                CachedAsyncImage(imageURL: trip.imageURLString, height: 200)
                    .overlay {
                        TripDetailImageOverlay(
                            trip: trip,
                            upcomingTrip: isUpcomingTrip
                        )
                    }
                    .padding()

                TripDetailInformationView(trip: trip, viewModel: viewModel)
                    
                Text("Quick Access")
                    .font(.system(.title3, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .horizontal])
                    
                HStack(spacing: 20) {
                    SquareCard(
                        title: "Itinerary",
                        value: "\(trip.dateDifference) Left",
                        iconName: "backpack.fill",
                        iconColor: .orange,
                        arrowColor: .orange
                    ) {
                        
                    }
                        
                    SquareCard(
                        title: "Map",
                        value: "\(trip.dateDifference) Left",
                        iconName: "map.fill",
                        iconColor: .accentBlue,
                        arrowColor: .accentBlue
                    ) { 
                        EventMapScreen(
                            trip: trip,
                            viewModel: appState.makeEventMapViewModel()
                        )
                    }
                }
                .padding(.horizontal)
                    
                TripBudgetCard(
                    title: "Budget",
                    totalSpend: trip.totalSpending,
                    budget: trip.budget,
                    iconName: "dollarsign",
                    iconColor: .accentConfirmation
                ) {
                    BudgetView(
                        viewModel: appState.makeBudgetViewModel(),
                        trip: $trip
                    )
                }
                .padding()
            }
        }
        .navigationTitle("\(trip.tripName)")
        .navigationBarTitleDisplayMode(.inline)
        .task(id: trip.id) {
            guard !Task.isCancelled else { return }
            await viewModel
                .getWeather(longitude: trip.longitude, latitude: trip.latitude)
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                ToolBarDeleteButton {
                    viewModel.toggleDeleteAlert()
                }
            }
            .sharedBackgroundVisibility(.hidden)
        }
        .toolbar(.hidden, for: .tabBar)
        .confirmDelete(showDeleteConfirmation:$viewModel.showDeleteAlert) {
            dismiss()
            Task {
                await viewModel.deleteTrip(tripId: trip.id)
            }
        }
        .showLoading(isLoading: viewModel.isNetworkActive)
    }
}

private struct TripDetailImageOverlay: View {
    let trip: Trip
    let upcomingTrip: Bool
    
    var body: some View {
        Group {
            VStack(alignment: .leading) {
                Spacer()
                
                Text(upcomingTrip ? "UPCOMING" : "PAST")
                    .padding(6)
                    .font(.system(.caption, weight: .bold))
                    .background(.accentPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Text(trip.location)
                    .font(.system(.title, weight: .bold))
                    
                HStack {
                    Image(systemName: "calendar")
                    
                    Text(trip.dateRangeString)
                    
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 5, height: 5)
                    
                    Text(trip.dateDifference)
                }
                .font(.subheadline)
            }
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
    }
}

private struct TripDetailInformationView: View {
    let trip: Trip
    let viewModel: TripDetailViewModel
    
    var body: some View {
        HStack(spacing: 20){
            TripDetailInformationCard(
                title: "STATUS",
                value: trip.dateDifference,
                iconName: "gauge.with.needle.fill",
                iconColor: .accentPrimary,
                textColor: .black
            )
                
            TripDetailInformationCard(
                title: trip.city,
                value: "\(viewModel.temperature) °C",
                iconName: viewModel.weatherIconName,
                iconColor: .accentPrimary,
                textColor: .black
            )
        }
        .padding(.horizontal)
    }
}

private struct TripDetailInformationCard: View {
    let title: String
    let value: String
    let iconName: String
    let iconColor: Color
    let textColor: Color
    
    var body: some View {
        OptionsCard {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .foregroundStyle(.secondaryText)
                    .font(.system(size: 12, weight: .semibold))
                    
                HStack {
                    Text(value)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(textColor)
                        
                    Spacer()
                        
                    CircleIcon(
                        iconName: iconName,
                        iconColor: iconColor,
                        width: 35,
                        height: 35
                    )
                    .padding(.trailing, 5)
                }
            }
            .padding()
        }
    }
}

private struct TripBudgetCard<T: View>: View {
    let title: String
    let totalSpend: Int
    let budget: Int
    let iconName: String
    let iconColor: Color
    @ViewBuilder let content: () -> T
    
    var body: some View {
        OptionsCard {
            VStack {
                HStack(spacing: 30) {
                    SquareIcon(
                        iconName: iconName,
                        iconColor: iconColor,
                        width: 50,
                        height: 50
                    )
                    .padding(.leading)
                        
                    VStack(alignment: .leading, spacing: 5) {
                        Text(title)
                            .font(.system(size: 17, weight: .semibold))
                            
                        Text("Current Spent: $\(totalSpend)")
                            .font(.system(size: 12))
                            .foregroundStyle(.secondaryText)
                    }
                        
                    Spacer()

                    NavigationLink {
                        content()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.accentConfirmation)
                        }
                    }
                }
                .padding()
                    
                LinearProgressBar(
                    value: Double(totalSpend) / Double(budget),
                    shape: RoundedRectangle(cornerRadius: 20)
                )
                .tint(.accentConfirmation)
                .frame(height: 12)
                .padding(.vertical, 4)
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

#Preview {
    TripDetailView(
        viewModel: AppState().makeTripDetailViewModel(),
        trip: .constant(Trip.example),
        isUpcomingTrip: true)
    .environment(AppState())
}
