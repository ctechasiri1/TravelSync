//
//  TripDetailScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/7/26.
//

import SwiftUI

struct TripDetailScreen: View {
    let trip: Trip
    let upcomingTrip: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                Group {
                    AsyncImage(url: trip.imageURLString) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 15))

                    } placeholder: {
                        ZStack {
                            Color.gray.opacity(0.5)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                            ProgressView()
                                .frame(width: 300, height: 200)
                        }
                    }
                }
                .overlay {
                    TripImageOverlay(trip: trip, upcomingTrip: upcomingTrip)
                }
                .padding()

                HStack(spacing: 20){
                    TripInformationCard(
                        title: "STATUS",
                        value: "\(trip.dateDifference)",
                        iconName: "gauge.with.needle.fill",
                        iconColor: .orange,
                        textColor: .orange
                    )
                        
                    TripInformationCard(
                        title: trip.city,
                        value: "18 ℃",
                        iconName: "sun.max.trianglebadge.exclamationmark.fill",
                        iconColor: .accentBlue,
                        textColor: .black
                    )
                }
                .padding(.horizontal)
                    
                Text("Quick Access")
                    .font(.system(.title3, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                HStack(spacing: 20) {
                    SquareCard(
                        title: "Itinerary",
                        value: "\(trip.dateDifference) Left",
                        iconName: "map.fill",
                        iconColor: .orange,
                        arrowColor: .orange
                    ) {
                        ItineraryScreen()
                    }
                        
                    SquareCard(
                        title: "Documents",
                        value: "\(trip.dateDifference) Left",
                        iconName: "backpack.fill",
                        iconColor: .accentBlue,
                        arrowColor: .accentBlue
                    ) {
                        ItineraryScreen()
                    }
                }
                .padding(.horizontal)
                    
                TripBudgetCard(
                    title: "Budget",
                    budget: "Total Budget: \(trip.budget)",
                    iconName: "dollarsign",
                    iconColor: .accentConfirmation
                ) {
                    BudgetScreen(trip: trip)
                }
                .padding()
            }
        }
        .navigationTitle("\(trip.tripName)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct TripImageOverlay: View {
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
                        .imageScale(.small)
                    
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

private struct TripInformationCard: View {
    let title: String
    let value: String
    let iconName: String
    let iconColor: Color
    let textColor: Color
    
    var body: some View {
        OptionsCard(title: "") {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .foregroundStyle(.secondaryText)
                        .font(.system(size: 12, weight: .semibold))
                    
                    Text(value)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(textColor)
                }
                .padding(5)
                
                Spacer()
                
                CircleIcon(
                    iconName: iconName,
                    iconColor: iconColor,
                    width: 35,
                    height: 35
                )
                .padding(.trailing, 5)
            }
            .padding(12)
        }
    }
}

private struct TripBudgetCard<T: View>: View {
    let title: String
    let budget: String
    let iconName: String
    let iconColor: Color
    @ViewBuilder let content: T
    
    var body: some View {
        OptionsCard(title: "") {
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
                            .font(.system(.headline, weight: .semibold))
                            
                        Text(budget)
                            .font(.system(size: 14))
                            .foregroundStyle(.secondaryText)
                    }
                        
                    Spacer()
                    
                    Text("Spent")
                        .font(.system(.caption, weight: .bold))
                        .padding(8)
                        .background(.gray.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .padding()

                LinearProgressBar(value: 0.1, shape: RoundedRectangle(cornerRadius: 20))
                    .tint(.accentConfirmation)
                    .frame(height: 12)
                    .padding(.vertical, 4)
                    .padding(.horizontal)
                
                NavigationLink {
                    content
                } label: {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.accentConfirmation)
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding()
        }
    }
}

#Preview {
    TripDetailScreen(
        trip: Trip.example,
        upcomingTrip: true)
        .environment(AppState())
}
