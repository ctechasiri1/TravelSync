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
        
        NavigationStack {
            ScrollView {
                Divider()
                
                CustomSegmentButton(selection: $tripsViewModel.selection,
                                    options: TripOption.allCases)
                .padding()
                
                if !tripsViewModel.trips.isEmpty {
                    Text("Next Adventure")
                        .sectionTitleStyle()
                }
                
                if let trip = tripsViewModel.trips.first {
                    NextTripCard(
                        urlString: "https://example.com/image.png",
                        imageHeight: 250,
                        travelDestination: trip.location,
                        travelDate: trip.dateRangeString
                    )
                }
                
                if tripsViewModel.trips.count > 1 {
                    Text("Future Plans")
                        .sectionTitleStyle()
                }

                ForEach(tripsViewModel.trips.dropFirst()) { trip in
                    FutureTripCard(urlString: "https://example.com/image.png", imageHeight: 150, travelDestination: trip.location, travelDate: "Jan 15 - 25 2026")
                        .padding(5)
                }

                AddTripButton(showPlanNewTrip: $tripsViewModel.showPlanNewTrip)
                
                Spacer()
            }
            .setScrollViewBackground()
            .fullScreenCover(isPresented: $tripsViewModel.showPlanNewTrip, content: {
                PlanNewTrip()
            })
            .navigationTitle(Text("My Trips"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CircleButton(imageName: "magnifyingglass") { }
                }
            }
        }
    }
}

private struct NextTripCard: View {
    let urlString: String
    let imageHeight: CGFloat
    let travelDestination: String
    let travelDate: String
    
    var body: some View {
        VStack {
            ImageWithPlaceHolder(urlString: urlString, imageHeight: imageHeight)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(travelDestination)
                            .font(.system(.title, weight: .bold))
                        
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundStyle(Color.accentBlue)
                            Text(travelDate)
                                .foregroundStyle(Color.secondaryText)
                        }
                    }
                    
                    Spacer()
                    
                    CircleIcon(iconName: "airplane.departure", iconColor: Color.accentBlue, width: 50, height: 50)
                }
                .padding()
                
                Divider()
                
                HStack {
                    Image(systemName: "circle.fill")
                    
                    Spacer()
                    
                    Text("View Itinerary")
                    Image(systemName: "arrow.forward")
                }
                .bold()
                .foregroundStyle(Color.accentBlue)
                .padding()
            }
            .padding()
        }
        .createCardBackgroud()
    }
}

private struct FutureTripCard: View {
    let urlString: String
    let imageHeight: CGFloat
    let travelDestination: String
    let travelDate: String
    
    var body: some View {
        VStack {
            ImageWithPlaceHolder(urlString: urlString, imageHeight: imageHeight)
            
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(travelDestination)
                                .font(.system(.title, weight: .bold))
                            
                            Spacer()
                            
                            Text("45 days")
                                .padding(10)
                                .foregroundStyle(Color.accentConfirmation)
                                .background(Color.green.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                        }
                        
                        Text(travelDate)
                            .foregroundStyle(Color.secondaryText)
                        
                        Text("5 days till trip")
                            .font(.system(.subheadline, weight: .regular))
                            .foregroundStyle(Color.accentBlue)
                    }
                }
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
                    .foregroundStyle(Color(.systemBlue))
                
                Text("Plan a new trip")
                    .font(.system(size: 18, weight: .semibold, design: .default))
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(Color.accentBlue.opacity(0.05)))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        Color.blue.opacity(0.2),
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
