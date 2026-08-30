//
//  TSTimePicker.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/28/26.
//

import SwiftUI

struct TSTimePicker: View {
    
    @Binding var selectedTime: Date?
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .sectionTitle()
            
            GeometryReader { geometry in
                HStack {
                    Text(selectedTime?.formattedShortenedTime ?? "Select Time")
                        .foregroundStyle(selectedTime == nil ? .secondary : .primary)
                        .animation(.default, value: selectedTime)
                    
                    Spacer()
                    
                    Image(systemName: "clock")
                        .foregroundStyle(.secondaryText)
                }
                .padding()
                .subtleRoundedBorder()
                .overlay {
                    DatePicker(
                        "",
                        selection: Binding(
                            get: { selectedTime ?? .now},
                            set: { selectedTime = $0 }
                        ),
                        displayedComponents: .hourAndMinute
                    )
                    .labelsHidden()
                    .colorMultiply(.clear)
                    .compositingGroup()
                    .scaleEffect(x: geometry.size.width / 90, y: geometry.size.height / 500)
                }
            }
        }
    }
}

#Preview("TSTimePicker - Start Time") {
    @State @Previewable var date: Date? = nil
    
    TSTimePicker(selectedTime: $date, title: "START TIME")
        .frame(width: 300)
}
