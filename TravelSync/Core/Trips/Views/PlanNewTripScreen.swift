//
//  PlanNewTripScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/24/26.
//

import SwiftUI

struct PlanNewTripScreen: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        @Bindable var tripsFeedViewModel = appState.tripsFeed
        
        ScrollView {
            SheetToolbar(title: "Add a Trip", enableSave: tripsFeedViewModel.canCreateTrip) {
                Task {
                    tripsFeedViewModel.canCreateTrip
                }
            }
            
            CoverImage(coverUIImage: $tripsFeedViewModel.coverUIImage)
                .padding(.horizontal, 6)
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Where to next?")
                        .font(.system(size: 30, weight: .semibold))
                    Text("Start planning your next adventure.")
                        .foregroundStyle(Color.secondaryText)
                }
                .padding(.vertical, 8)
                
                InputTextField(
                    text: $tripsFeedViewModel.locationName,
                    fieldTitle: "LOCATION",
                    fieldImage: "location.fill",
                    fieldContent: "City, airport, or hotel",
                    iconColor: .secondaryText
                )
                .padding(.vertical, 8)
                
                InputTextField(
                    text: $tripsFeedViewModel.tripName,
                    fieldTitle: "TRIP NAME",
                    fieldImage: "pencil",
                    fieldContent: "e.g. Summer in Toyko",
                    iconColor: .secondaryText
                )
                .padding(.vertical, 8)
                
                InputTextField(
                    text: $tripsFeedViewModel.budget,
                    fieldTitle: "BUDGET",
                    fieldImage: "banknote.fill",
                    fieldContent: "e.g. 10,000",
                    iconColor: .secondaryText
                )
                .padding(.vertical, 8)
                
                HStack {
                    CustomDatePicker(
                        selectedDate: $tripsFeedViewModel.startDate,
                        pickerTitle: "START DATE"
                    )
                    
                    Image(systemName: "arrow.right")
                        .foregroundStyle(.secondaryText)
                        .padding(.top, 25)
                    
                    CustomDatePicker(
                        selectedDate: $tripsFeedViewModel.endDate,
                        pickerTitle: "END DATE"
                    )
                }
                
                OptionsCard(title: "PREFERNCES") {
                    ToggleOptionRow(
                        title: "Auto Time Zone",
                        iconName: "clock.fill",
                        isOn: $tripsFeedViewModel.pushNotificationsIsOn
                    )
                    .padding(.top, 15)
                    
                    Divider()
                        .padding(.vertical, 5)
                    
                    ToggleOptionRow(
                        title: "Notifications",
                        iconName: "bell.fill",
                        isOn: $tripsFeedViewModel.pushNotificationsIsOn
                    )
                    .padding(.bottom, 15)
                }
                .padding(.top, 20)
                
                CreateTripButton() {
                    Task {
                        try await tripsFeedViewModel.addTrip()
                    }
                }
                .padding(.vertical)
                .disabled(!tripsFeedViewModel.canCreateTrip)
                .opacity(!tripsFeedViewModel.canCreateTrip ? 0.5 : 1.0)
                .animation(.easeInOut, value: tripsFeedViewModel.canCreateTrip)
            }
            .padding(.horizontal)
        }
        .toolbar(.hidden, for: .tabBar)
        .scrollIndicators(.hidden)
    }
}

private struct CreateTripButton: View {
    @Environment(\.dismiss) var dismiss
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
            dismiss()
        } label: {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Create Trip")
            }
            .padding()
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    colors: [Color.orange, Color.accentPrimary],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    PlanNewTripScreen()
        .environment(AppState())
}
