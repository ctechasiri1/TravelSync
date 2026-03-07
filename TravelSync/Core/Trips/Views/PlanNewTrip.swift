//
//  PlanNewTrip.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/24/26.
//

import SwiftUI

struct PlanNewTrip: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        @Bindable var tripsViewModel = appState.trips
        
        ScrollView {
            NavigationOption()
            
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
                    fieldContent: "City, airport, or hotel"
                )
                
                InputTextField(
                    text: $tripsViewModel.tripName,
                    fieldTitle: "TRIP NAME",
                    fieldImage: "pencil",
                    fieldContent: "e.g. Summer in Toyko"
                )
                
                // TODO: Fix the spacing in the start and end date section
                HStack {
                    CustomDatePicker(
                        selectedDate: $tripsViewModel.startDate,
                        pickerTitle: "START DATE"
                    )
                    
                    Image(systemName: "arrow.right")
                        .foregroundStyle(Color.accentBlue)
                        .padding(.top, 25)
                    
                    CustomDatePicker(
                        selectedDate: $tripsViewModel.endDate,
                        pickerTitle: "END DATE"
                    )
                }
                .padding(.leading, 35)
                
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
                    do {
                        try tripsViewModel.addTrip()
                    } catch {
                        tripsViewModel.errorMessage = error.localizedDescription
                        tripsViewModel.showErrorAlert = true
                    }
                    
                }
                .padding()
                .disabled(!tripsViewModel.canCreateTrip)
                .opacity(!tripsViewModel.canCreateTrip ? 1.0 : 0.5)
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

private struct NavigationOption: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
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
                
            } label: {
                Text("Save")
            }
            .frame(maxWidth: .infinity)
        }
    }
}

private struct InputTextField: View {
    @Binding var text: String
    let fieldTitle: String
    let fieldImage: String
    let fieldContent: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(fieldTitle)
                .foregroundStyle(Color.primaryText)
                .font(.system(size: 15, weight: .semibold))
                .padding(.leading, 5)
            
            HStack {
                Image(systemName: fieldImage)
                TextField(text: $text) {
                    Text(fieldContent)
                }
            }
            .foregroundStyle(Color.secondaryText.opacity(0.5))
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        Color.secondaryText.opacity(0.2),
                        style: StrokeStyle(lineWidth: 1)
                    )
            )
        }
        .padding()
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
                
                Spacer()
                
                Image(systemName: "calendar")
                    .foregroundStyle(.accentBlue)
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
                // TODO: I need to review this logic
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
                    colors: [Color.orange, Color.pink],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    PlanNewTrip()
        .environment(AppState())
}
