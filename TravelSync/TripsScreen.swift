//
//  TripsScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 12/31/25.
//

import SwiftUI

struct TripsScreen: View {
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
                
                NextAdventureCard()
                    .padding()
                
                Text("Future Plans")
                    .foregroundStyle(Color.textColor.placeholderText)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                

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
    TripsScreen()
}
