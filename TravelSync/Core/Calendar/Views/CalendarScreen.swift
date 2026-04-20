//
//  CalendarScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/19/26.
//

import SwiftUI

struct CalendarScreen: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: CalendarViewModel
    
    init(viewModel: CalendarViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyVStack(spacing: 15) {
                HStack(spacing: 10) {
                    ForEach(viewModel.currentWeek, id: \.self) { day in
                        VStack {
                            Text(day.extractDate(format: "dd"))
                                .font(.system(size: 15, weight: .semibold))
                            
                            Text(day.extractDate(format: "EEE"))
                                .font(.system(size: 14))
                            
                            Circle()
                                .fill(.white)
                                .frame(width: 8, height: 8)
                        }
                        .foregroundStyle(.white)
                        .frame(width: 45, height: 90)
                        .background {
                            
                            Capsule()
                                .fill()
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(Date().dateToStringMonthDayYear)
                        .foregroundStyle(.gray)
                    
                    Text("Today")
                        .font(.system(.largeTitle, weight: .bold))
                }
                .fixedSize(horizontal: true, vertical: false)
            }
            .sharedBackgroundVisibility(.hidden)
        }
    }
}

#Preview {
    CalendarScreen(viewModel: CalendarViewModel())
        .environment(AppState())
}
