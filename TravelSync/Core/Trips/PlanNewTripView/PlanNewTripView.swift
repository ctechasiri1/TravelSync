//
//  PlanNewTripView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/24/26.
//

import MapKit
import SwiftUI

struct PlanNewTripView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: PlanNewTripViewModel
    
    init(viewModel: PlanNewTripViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            SheetToolbar(
                title: "Add a Trip",
                enableSave: viewModel.canCreateTrip
            ) {
                Task {
                    await viewModel.addTrip()
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
                
                LocationSearchField(
                    text: $viewModel.locationName,
                    fieldTitle: "LOCATION",
                    fieldImage: "location.fill",
                    fieldContent: "City, airport, or hotel",
                    iconColor: .secondaryText,
                    completions: viewModel.getCompletions()) {
                        viewModel.resetCompletions()
                    } onChangeAction: {
                        viewModel.updateLocationSearchResults()
                    }
                    .zIndex(1)
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
                .keyboardType(.decimalPad)
                .padding(.vertical, 8)
                
                PlanNewTripSelectDateView(
                    startDate: $viewModel.startDate,
                    endDate: $viewModel.endDate
                )
                
                PlanNewTripPreferenceView(
                    isPushNotificationOn: $viewModel.isPushNotificationOn
                )
                
                MultipurposeButton(
                    buttonImageString: "plus.circle.fill",
                    buttonText: "Create Trip",
                    foregroundColor: .white,
                    backgroundColor: .accentPrimary) {
                        Task {
                            await viewModel.addTrip()
                            await MainActor.run {
                                dismiss()
                            }
                        }
                    }
                    .padding(.vertical)
                    .disabled(!viewModel.canCreateTrip)
                    .opacity(!viewModel.canCreateTrip ? 0.5 : 1.0)
                    .animation(.smooth, value: viewModel.canCreateTrip)
            }
            .padding(.horizontal)
        }
        .toolbar(.hidden, for: .tabBar)
        .scrollIndicators(.hidden)
        .showLoading(isLoading: viewModel.isNetworkActive)
    }
}

private struct PlanNewTripSelectDateView: View {
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    
    var body: some View {
        HStack {
            CustomDatePicker(
                selectedDate: $startDate,
                pickerTitle: "START DATE"
            )
            
            Image(systemName: "arrow.right")
                .foregroundStyle(.secondaryText)
                .padding(.top, 25)
            
            CustomDatePicker(
                selectedDate: $endDate,
                pickerTitle: "END DATE"
            )
        }
    }
}

private struct PlanNewTripPreferenceView: View {
    @Binding var isPushNotificationOn: Bool
    
    var body: some View {
        OptionsCard(title: "PREFERNCES") {
            ToggleOptionRow(
                isOn: $isPushNotificationOn,
                title: "Auto Time Zone",
                iconName: "clock.fill"
            )
            .padding(.top, 15)
            
            Divider()
                .padding(.vertical, 5)
            
            ToggleOptionRow(
                isOn: $isPushNotificationOn,
                title: "Notifications",
                iconName: "bell.fill"
            )
            .padding(.bottom, 15)
        }
        .padding(.top, 20)
    }
}

#Preview {
    PlanNewTripView(
        viewModel: PlanNewTripViewModel(
            tripService: TripService(
                networkService: NetworkRequestService(),
                keychainService: KeychainService()
            ),
            locationSearchManager: LocationSearchManager(
                completer: MKLocalSearchCompleter()
            )
        )
    )
    .environment(AppState())
}
