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
        @Bindable var tripsViewModel = appState.trips
        
        ScrollView {
            NavigationOption() {
                Task {
                    tripsViewModel.canCreateTrip
                }
            }
            
            CoverImage()
                .padding()
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Where to next?")
                        .font(.system(size: 30, weight: .semibold))
                    Text("Start planning your next adventure.")
                        .foregroundStyle(Color.secondaryText)
                }
                .padding()
                
                InputTextField(
                    text: $tripsViewModel.locationName,
                    fieldTitle: "LOCATION",
                    fieldImage: "location.fill",
                    fieldContent: "City, airport, or hotel",
                    iconColor: .secondaryText
                )
                
                InputTextField(
                    text: $tripsViewModel.tripName,
                    fieldTitle: "TRIP NAME",
                    fieldImage: "pencil",
                    fieldContent: "e.g. Summer in Toyko",
                    iconColor: .secondaryText
                )
                
                InputTextField(
                    text: $tripsViewModel.budget,
                    fieldTitle: "BUDGET",
                    fieldImage: "banknote.fill",
                    fieldContent: "e.g. 10,000",
                    iconColor: .secondaryText
                )
                
                HStack {
                    CustomDatePicker(
                        selectedDate: $tripsViewModel.startDate,
                        pickerTitle: "START DATE"
                    )
                    
                    Image(systemName: "arrow.right")
                        .foregroundStyle(.secondaryText)
                        .padding(.top, 25)
                    
                    CustomDatePicker(
                        selectedDate: $tripsViewModel.endDate,
                        pickerTitle: "END DATE"
                    )
                }
                
                OptionsCard(title: "PREFERNCES") {
                    ToggleOptionRow(
                        title: "Auto Time Zone",
                        iconName: "clock.fill",
                        isOn: $tripsViewModel.pushNotificationsIsOn
                    )
                    .padding(.top, 15)
                    
                    Divider()
                        .padding(.vertical, 5)
                    
                    ToggleOptionRow(
                        title: "Notifications",
                        iconName: "bell.fill",
                        isOn: $tripsViewModel.pushNotificationsIsOn
                    )
                    .padding(.bottom, 15)
                }
                .padding(.top, 20)
                
                CreateTripButton() {
                    Task {
                        try await tripsViewModel.addTrip()
                    }
                }
                .padding(.vertical)
                .disabled(!tripsViewModel.canCreateTrip)
                .opacity(!tripsViewModel.canCreateTrip ? 0.5 : 1.0)
                .animation(.easeInOut, value: tripsViewModel.canCreateTrip)
            }
            .padding(.horizontal)
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

private struct NavigationOption: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    let saveAction: () -> Void
    
    var body: some View {
        let tripsViewModel = appState.trips
        
        HStack {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
            }
            .frame(maxWidth: .infinity)
            
            Text("Add a trip")
                .foregroundStyle(Color.primaryText)
                .font(.system(size: 20, weight: .semibold))
                .padding(.leading, 5)
                .frame(maxWidth: .infinity)
            
            Button {
                saveAction()
            } label: {
                Text("Save")
            }
            .frame(maxWidth: .infinity)
            .disabled(!tripsViewModel.canCreateTrip)
            .opacity(!tripsViewModel.canCreateTrip ? 0.5 : 1.0)
            .animation(.easeInOut, value: tripsViewModel.canCreateTrip)
        }
    }
}

private struct CustomDatePicker: View {
    @Binding var selectedDate: Date?
    let pickerTitle: String
    
    var body: some View {
        VStack {
            Text(pickerTitle)
                .foregroundStyle(Color.primaryText)
                .font(.system(size: 15, weight: .semibold))
            
            HStack {
                Text(selectedDate?.formatted(date: .abbreviated, time: .omitted) ?? "Select Date")
                    .foregroundStyle(selectedDate == nil ? .secondary : .primary)
                    .animation(.default, value: selectedDate)
                
                Spacer()
                
                Image(systemName: "calendar")
                    .foregroundStyle(.secondaryText)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        Color.secondaryText.opacity(0.2),
                        style: StrokeStyle(lineWidth: 1)
                    )
            )
            .overlay {
                DatePicker(
                    "",
                    selection: Binding(
                        get: { selectedDate ?? .now },
                        set: { selectedDate = $0 }
                    ),
                    displayedComponents: .date
                )
                .labelsHidden()
                .colorMultiply(.clear)
            }
        }
        .padding(.vertical)
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
