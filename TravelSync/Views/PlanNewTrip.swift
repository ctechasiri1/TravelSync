//
//  PlanNewTrip.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 2/24/26.
//

import SwiftUI

struct PlanNewTrip: View {
    @Environment(\.dismiss) private var dismiss
    @State private var planNewTripViewModel: PlanNewTripViewModel = PlanNewTripViewModel()
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
            }
            
            Button {
                
            } label: {
                Text("Save")
            }

        }
        
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
                CustomDatePicker(selectedDate: $planNewTripViewModel.startDate, pickerTitle: "START DATE")
                
                Image(systemName: "arrow.right")
                    .foregroundStyle(Color.accentBlue)
                    .padding(.top, 25)
                
                CustomDatePicker(selectedDate: $planNewTripViewModel.endDate, pickerTitle: "END DATE")
            }
            .padding(.leading, 10)
            
            PreferenceSection()
                .padding()
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
                    .stroke(Color.secondaryText.opacity(0.2), style: StrokeStyle(lineWidth: 1))
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
                    .stroke(Color.secondaryText.opacity(0.2), style: StrokeStyle(lineWidth: 1))
                
                DatePicker(selection: $selectedDate, displayedComponents: .date) {}
                .labelsHidden()
                .colorMultiply(.clear)
            }
        }
        .padding(.vertical)
    }
}

private struct PreferenceSection: View {
    var body: some View {
        Text("PREFERENCES")
            .foregroundStyle(Color.primaryText)
            .font(.system(size: 15, weight: .semibold))
            .padding(.leading, 5)
    }
}


#Preview {
    PlanNewTrip()
}
