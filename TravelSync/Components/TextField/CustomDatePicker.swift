//
//  CustomDatePicker.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/10/26.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var selectedDate: Date?
    let pickerTitle: String
    
    var body: some View {
        VStack {
            Text(pickerTitle)
                .foregroundStyle(Color.primaryText)
                .font(.system(size: 15, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
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
#Preview {
    @Previewable @State var date: Date? = .now
    
    CustomDatePicker(selectedDate: $date, pickerTitle: "Transaction Date")
}
