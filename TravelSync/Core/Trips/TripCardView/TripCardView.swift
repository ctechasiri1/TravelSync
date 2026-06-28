//
//  TripCardView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 6/10/26.
//

import SwiftUI

struct TripFeedCardView: View {
    @State var trip: Trip
    let viewModel: TripsFeedViewModel
    let height: CGFloat
    let isUpcomingTrip: Bool
    var isFirstUpcomingTrip: Bool = false
    
    @State private var isFavoriteUpdated: Bool = false

    var body: some View {
        VStack {
            CachedAsyncImage(imageURL: trip.imageURLString, height: height)
                .overlay(alignment: .center) {
                    CardContent(
                        trip: $trip,
                        isFavorite: $isFavoriteUpdated,
                        dateDifference: trip.dateDifference,
                        isFirstUpcomingTrip: isFirstUpcomingTrip,
                        isUpcomingTrip: isUpcomingTrip) {
                            Task {
                                await viewModel.updateTrip(
                                    tripId: trip.id,
                                    isFavorite: isFavoriteUpdated,
                                    coverImage: nil
                                )
                            }
                        }
                        .padding()
                }
        }
        .onAppear {
            setIsFavorite()
        }
        .onChange(of: trip.isFavorite) { oldValue, newValue in
            isFavoriteUpdated = newValue
        }
    }
    
    private func setIsFavorite() {
        isFavoriteUpdated = trip.isFavorite
    }
}

private struct CardContent: View {
    @Environment(AppState.self) private var appState
    @Binding var trip: Trip
    @Binding var isFavorite: Bool
    let dateDifference: String
    let isFirstUpcomingTrip: Bool
    let isUpcomingTrip: Bool
    let onFavoriteToggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                HStack {
                    Image(systemName: "clock.fill")
                    
                    Text(dateDifference)
                }
                .font(.system(.subheadline, weight: .semibold))
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .foregroundColor(.white)
                .background(.accentPrimary)
                .clipShape(Capsule())
                .padding(5)
                
                Spacer()
                
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .styledButton(buttonStyle: .text, foregroundColor: .accentPrimary, backgroundColor: .clear, action: {
                        isFavorite.toggle()
                        onFavoriteToggle()
                    })
                    .padding(.horizontal)
            }
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("\(trip.city),")
                            .font(
                                .system(
                                    size: isFirstUpcomingTrip ? 28 : 26,
                                    weight: .bold
                                )
                            )
                        
                        Text("\(trip.country)")
                            .font(
                                .system(
                                    size: isFirstUpcomingTrip ? 28 : 26,
                                    weight: .bold
                                )
                            )
                    }
                    .foregroundStyle(.white)
                    .padding(10)
                    
                    HStack {
                        Group {
                            Image(systemName: "calendar")
                            
                            Text(trip.dateRangeString)
                        }
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white)
                        
                        Spacer()
                        
                        DetailsButton {
                            TripDetailView(
                                viewModel: appState
                                    .makeTripDetailViewModel(),
                                trip: $trip,
                                isUpcomingTrip: isUpcomingTrip
                            )
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

private struct DetailsButton<T: View>: View {
    @ViewBuilder let content: () -> T
    
    var body: some View {
        NavigationLink {
            content()
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

#Preview {
    TripFeedCardView(
        trip: Trip.example,
        viewModel: TripsFeedViewModel(
            tripService: TripService(
                networkService: NetworkRequestService(),
                keychainService: KeychainService()
            )
        ),
        height: 350,
        isUpcomingTrip: true
    )
    .environment(AppState())
}
