//
//  TripsScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/31/25.
//

import SwiftUI

struct TripsScreen: View {
    @State private var viewModel: TripsViewModel = TripsViewModel()
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        NavigationStack {
            ScrollView {
                Divider()
                
                CustomSegmentButton(selection: $viewModel.selection,
                                    options: TripOption.allCases)
                .padding()
                
                Text("Next Adventure")
                    .sectionTitleStyle()
                
                if let location = viewModel.trips.first?.location {
                    NextTripCard(urlString: "https://example.com/image.png", imageHeight: 250, travelDestination: location, travelDate: "Jan 15 - 25 2026")
                        .padding(5)
                }
                
                Text("Future Plans")
                    .sectionTitleStyle()
                
                ForEach(viewModel.trips.dropFirst()) { trip in
                    FutureTripCard(urlString: "https://example.com/image.png", imageHeight: 150, travelDestination: trip.location, travelDate: "Jan 15 - 25 2026")
                        .padding(5)
                }
                
            }
            .setScrollViewBackground()
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

#Preview {
    TripsScreen()
}
