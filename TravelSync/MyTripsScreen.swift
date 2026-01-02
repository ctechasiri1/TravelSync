//
//  MyTripsScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/31/25.
//

import SwiftUI

struct MyTripsScreen: View {
    @State private var selection: TripOption = .upcoming
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Divider()
                
                CustomSegmentButton(selection: $selection,
                                    options: TripOption.allCases)
                    .padding()
                
                Text("Next Adventure")
                    .foregroundStyle(Color.textColor.placeholderText)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                NextAdventureCard(urlString: "https://example.com/image.png", imageHeight: 250, travelDestination: "Tokyo, Japan", travelDate: "Jan 15 - 25 2026")
                    .padding(20)
                
                Text("Future Plans")
                    .foregroundStyle(Color.textColor.placeholderText)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                FuturePlansCard(urlString: "https://example.com/image.png", imageHeight: 150, travelDestination: "Tokyo, Japan", travelDate: "Jan 15 - 25 2026")
                    .padding(20)
                
            }
            .scrollContentBackground(.hidden)
            .background(Color.backgroundColor.primaryBackground)
            .navigationTitle(Text("My Trips"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CircleButton(imageName: "magnifyingglass") { }
                }
            }
        }
    }
}

#Preview {
    MyTripsScreen()
}
