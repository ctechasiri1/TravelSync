//
//  TimePicker.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/28/26.
//

import SwiftUI

struct TimePicker: View {
    @Binding var selectedTime: Date?
    let pickerTitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(pickerTitle)
                .foregroundStyle(Color.primaryText)
                .font(.system(size: 15, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            HStack {
                Text(selectedTime?.formatted(date: .omitted, time: .shortened) ?? "Select Time")
                    .foregroundStyle(selectedTime == nil ? .secondary : .primary)
                    .animation(.default, value: selectedTime)
                
                Image(systemName: "clock")
                    .foregroundStyle(.secondaryText)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(
                        Color.secondaryText.opacity(0.2),
                        style: StrokeStyle(lineWidth: 1)
                    )
            )
            .overlay {
                DatePicker(
                    "",
                    selection: Binding(
                        get: { selectedTime ?? .now },
                        set: { selectedTime = $0 }),
                    displayedComponents: .hourAndMinute
                )
                .labelsHidden()
                .colorMultiply(.clear)
                .compositingGroup()
                .scaleEffect(x: 3, y: 1.5)
            }
        }
    }
}

#Preview {
    @Previewable @State var date: Date? = nil
    
    TimePicker(selectedTime: $date, pickerTitle: "START TIME")
}
