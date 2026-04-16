//
//  PlanNewTripScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/24/26.
//

import SwiftUI

struct PlanNewTripScreen: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: PlanNewTripViewModel
    
    init(viewModel: PlanNewTripViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            SheetToolbar(title: "Add a Trip", enableSave: viewModel.canCreateTrip) {
                Task {
                    do {
                        try await viewModel.addTrip()
                    } catch {
                        
                    }
                }
            }
            
            CoverImage(coverUIImage: $viewModel.coverUIImage)
                .padding(.horizontal, 10)
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Where to next?")
                        .font(.system(size: 30, weight: .semibold))
                    Text("Start planning your next adventure.")
                        .foregroundStyle(Color.secondaryText)
                }
                .padding(.vertical, 8)
                
                InputTextField(
                    text: $viewModel.locationName,
                    fieldTitle: "LOCATION",
                    fieldImage: "location.fill",
                    fieldContent: "City, airport, or hotel",
                    iconColor: .secondaryText
                )
                .padding(.vertical, 8)
                
                InputTextField(
                    text: $viewModel.tripName,
                    fieldTitle: "TRIP NAME",
                    fieldImage: "pencil",
                    fieldContent: "e.g. Summer in Toyko",
                    iconColor: .secondaryText
                )
                .padding(.vertical, 8)
                
                InputNumberField(
                    currency: $viewModel.budget,
                    fieldTitle: "BUDGET",
                    fieldImage: "banknote.fill",
                    fieldContent: "e.g. 10,000",
                    iconColor: .secondaryText
                )
                .padding(.vertical, 8)
                
                HStack {
                    CustomDatePicker(
                        selectedDate: $viewModel.startDate,
                        pickerTitle: "START DATE"
                    )
                    
                    Image(systemName: "arrow.right")
                        .foregroundStyle(.secondaryText)
                        .padding(.top, 25)
                    
                    CustomDatePicker(
                        selectedDate: $viewModel.endDate,
                        pickerTitle: "END DATE"
                    )
                }
                
                OptionsCard(title: "PREFERNCES") {
                    ToggleOptionRow(
                        title: "Auto Time Zone",
                        iconName: "clock.fill",
                        isOn: $viewModel.pushNotificationsIsOn
                    )
                    .padding(.top, 15)
                    
                    Divider()
                        .padding(.vertical, 5)
                    
                    ToggleOptionRow(
                        title: "Notifications",
                        iconName: "bell.fill",
                        isOn: $viewModel.pushNotificationsIsOn
                    )
                    .padding(.bottom, 15)
                }
                .padding(.top, 20)
                
                CreateTripButton() {
                    Task {
                        try await viewModel.addTrip()
                    }
                }
                .padding(.vertical)
                .disabled(!viewModel.canCreateTrip)
                .opacity(!viewModel.canCreateTrip ? 0.5 : 1.0)
                .animation(.easeInOut, value: viewModel.canCreateTrip)
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
    PlanNewTripScreen(viewModel: PlanNewTripViewModel(tripService: TripService(networkService: NetworkRequestService(), keychainService: KeychainService())))
        .environment(AppState())
}
