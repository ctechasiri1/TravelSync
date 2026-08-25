//
//  TSDatePicker.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/10/26.
//

import SwiftUI

struct TSDatePicker: View {
    
    let title: String
    @Binding var selectedDate: Date?
    
    var body: some View {
        VStack {
            Text(title)
                .sectionTitle()
            
            HStack {
                Text(selectedDate?.formatted(date: .abbreviated, time: .omitted) ?? "Select Date")
                    .foregroundStyle(selectedDate == nil ? .secondary : .primary)
                    .animation(.linear, value: selectedDate)
                
                Spacer()
                
                Image(systemName: "calendar")
                    .foregroundStyle(.secondaryText)
            }
            .padding()
            .overlay {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(
                            Color.secondaryText.opacity(0.2),
                            style: StrokeStyle(lineWidth: 1)
                        )
                    
                    DatePicker(
                        "",
                        selection: Binding(
                            get: { selectedDate ?? .now },
                            set: { selectedDate = $0 }
                        ),
                        in: Date.now...,
                        displayedComponents: .date
                    )
                    .labelsHidden()
                    .colorMultiply(.clear)
                    .compositingGroup()
                    .scaleEffect(x: 3, y: 1.5)
                }
            }
        }
    }
}

#Preview("TSDatePicker") {
    @State @Previewable var date: Date? = .now
    
    ZStack {
        Color.primaryBackground
            .ignoresSafeArea()
        
        GroupCard {
            VStack(alignment: .leading) {
                TSDatePicker(title: "Transaction Date", selectedDate: $date)
            }
            .padding()
        }
        .padding()
    }
}
