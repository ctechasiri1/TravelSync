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
        @Bindable var planNewTripViewModel = appState.planNewTrip
        
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
                    text: $planNewTripViewModel.locationName,
                    fieldTitle: "LOCATION",
                    fieldImage: "location.fill",
                    fieldContent: "City, airport, or hotel"
                )
                
                InputTextField(
                    text: $planNewTripViewModel.tripName,
                    fieldTitle: "TRIP NAME",
                    fieldImage: "pencil",
                    fieldContent: "e.g. Summer in Toyko"
                )
                
                HStack {
                    CustomDatePicker(
                        selectedDate: $planNewTripViewModel.startDate,
                        pickerTitle: "START DATE"
                    )
                    
                    Image(systemName: "arrow.right")
                        .foregroundStyle(Color.accentBlue)
                        .padding(.top, 25)
                    
                    CustomDatePicker(
                        selectedDate: $planNewTripViewModel.endDate,
                        pickerTitle: "END DATE"
                    )
                }
                .padding(.leading, 35)
                
                OptionsCard(title: "PREFERNCES") {
                    ToggleOptionRow(
                        title: "Auto Time Zone",
                        iconName: "clock.fill",
                        isOn: $planNewTripViewModel.pushNotificationsIsOn
                    )
                    .padding(.top, 15)
                    
                    Divider()
                        .padding(.vertical, 5)
                    
                    ToggleOptionRow(
                        title: "Notifications",
                        iconName: "bell.fill",
                        isOn: $planNewTripViewModel.pushNotificationsIsOn
                    )
                    .padding(.bottom, 15)
                }
                .padding(.top, 20)
                
                CreateTripButton()
                    .padding()
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
    @Binding var selectedDate: Date
    let pickerTitle: String
    
    var body: some View {
        VStack {
            Text(pickerTitle)
                .foregroundStyle(Color.primaryText)
                .font(.system(size: 15, weight: .semibold))
            
            HStack {
                if selectedDate != Date() {
                    Text("\(selectedDate, style: .date)")
                } else {
                    Image(systemName: "calendar")
                    Text("Select")
                }
            }
            .foregroundStyle(Color.secondaryText.opacity(0.5))
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        Color.secondaryText.opacity(0.2),
                        style: StrokeStyle(lineWidth: 1)
                    )
                
                DatePicker(
                    selection: $selectedDate,
                    displayedComponents: .date
                ) {
                }
                .labelsHidden()
                .colorMultiply(.clear)
            }
        }
        .padding(.vertical)
    }
}

private struct CreateTripButton: View {
    var body: some View {
        Button {
            
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
