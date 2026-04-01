//
//  TripScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/7/26.
//

import SwiftUI

struct TripScreen: View {
    let trip: Trip
    let upcomingTrip: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: trip.imageURLString)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay {
                        TripImageOverlay(trip: trip, upcomingTrip: upcomingTrip)
                    }
                    .padding()
                    
                HStack(spacing: 20){
                    TripInformationCard(
                        title: "STATUS",
                        value: "\(trip.dateDiffernce ?? "0 Days") Left",
                        iconName: "gauge.with.needle.fill",
                        iconColor: .accentBlue,
                        textColor: .accentBlue
                    )
                        
                    TripInformationCard(
                        title: trip.city,
                        value: "18 ℃",
                        iconName: "sun.max.trianglebadge.exclamationmark.fill",
                        iconColor: .accentConfirmation,
                        textColor: .black
                    )
                }
                .padding(.horizontal)
                    
                Text("Quick Access")
                    .font(.system(.title3, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                HStack(spacing: 20) {
                    TripQuickAccessCard(
                        title: "Itinerary",
                        value: "\(trip.dateDiffernce ?? "0 Days") Left",
                        iconName: "map.fill",
                        iconColor: .accentBlue
                    ) {
                        ItineraryScreen()
                    }
                        
                    TripQuickAccessCard(
                        title: "Documents",
                        value: "\(trip.dateDiffernce ?? "0 Days") Left",
                        iconName: "ticket.fill", iconColor: .accentConfirmation
                    ) {
                        ItineraryScreen()
                    }
                }
                .padding(.horizontal)
                    
                TripBudgetCard(
                    title: "Documents",
                    value: "\(trip.dateDiffernce ?? "0 Days") Left",
                    iconName: "ticket.fill",
                    iconColor: .accentConfirmation
                )
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
                
                Text(upcomingTrip ? "UPCOMING" : "FUTURE")
                    .padding(6)
                    .font(.system(.caption, weight: .bold))
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Text(trip.tripName)
                    .font(.system(.title, weight: .bold))
                    
                HStack {
                    Image(systemName: "calendar")
                    
                    Text(trip.dateRangeString)
                    
                    Image(systemName: "circle.fill")
                        .imageScale(.small)
                    
                    Text(trip.dateDiffernce ?? "0 days")
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
                
                CircleIcon(iconName: iconName, iconColor: iconColor, width: 35, height: 35)
                    .padding(.trailing, 5)
            }
            .padding(12)
        }
    }
}

private struct TripQuickAccessCard<T:View>: View {
    let title: String
    let value: String
    let iconName: String
    let iconColor: Color
    @ViewBuilder let content: T
    
    var body: some View {
        NavigationLink {
            content
        } label: {
            OptionsCard(title: "") {
                HStack {
                    VStack(alignment: .leading) {
                        SquareIcon(
                            iconName: iconName,
                            iconColor: iconColor,
                            width: 50,
                            height: 50
                        )
                        .padding(.leading, 5)
                        .padding([.top, .bottom], 10)
                        .imageScale(.large)
                        

                        VStack(alignment: .leading, spacing: 5) {
                            Text(title)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.black)
                                
                            Text(value)
                                .font(.system(size: 13))
                                .foregroundStyle(.secondaryText)
                                
                        }
                        .padding([.top, .bottom, .trailing], 15)
                        
                        HStack {
                            Spacer()
                            Image(systemName: "arrow.right")
                                .foregroundStyle(.accentBlue)
                        }
                    }
                    .padding(20)
                }
            }
        }
    }
}

private struct TripBudgetCard: View {
    let title: String
    let value: String
    let iconName: String
    let iconColor: Color
    
    var body: some View {
        OptionsCard(title: "") {
            VStack {
                HStack(spacing: 50) {
                    HStack(spacing: 30) {
                        SquareIcon(
                            iconName: iconName,
                            iconColor: iconColor,
                            width: 50,
                            height: 50
                        )
                        
                        VStack(alignment: .leading) {
                            Text(title)
                                .font(.system(.headline, weight: .semibold))
                            Text(value)
                                .font(.system(.subheadline))
                                .foregroundStyle(.secondaryText)
                        }
                    }
                    
                    Text(title)
                        .font(.system(.subheadline, weight: .semibold))
                        .padding(8)
                        .background(.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .padding()
                
                ProgressView(value: 10, total: 100)
                    .tint(.accentConfirmation)
                    .progressViewStyle(.linear)
                    .scaleEffect(y: 2.0)
                    .padding([.leading, .trailing, .bottom])
            }
            .padding()
        }
    }
}

//#Preview {
//    TripScreen(
//        trip: Trip(
//            tripName: "Summer in Thailand",
//            location: "Bangkok, Thailand",
//            budget: "1_000",
//            startDate: Calendar.current.date(byAdding: .day, value: -7, to: Date.now) ?? .now,
//            endDate: Calendar.current.date(byAdding: .day, value: -5, to: Date.now) ?? .now,
//            coverImage: UIImage(named: "tempBackground")),
//        upcomingTrip: true)
//        .environment(AppState())
//}
