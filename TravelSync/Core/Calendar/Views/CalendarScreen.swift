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
        VStack(alignment: .leading) {
            VStack(spacing: 10) {
                Text("Today")
                    .font(.system(.largeTitle, weight: .bold))
                
                Text(Date().dateToStringMonthDayYear)
                    .foregroundStyle(.gray)
            }
            .padding()
            
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
                                    .opacity(viewModel.isSelectDay(date: day) ? 1 : 0)
                            }
                            .foregroundStyle(viewModel.isSelectDay(date: day) ? .white : .secondaryText.opacity(0.5))
                            .frame(width: 60, height: 90)
                            .background(
                                Capsule()
                                    .fill(viewModel.isSelectDay(date: day) ? .accentPrimary : .white)
                            )
                            .onTapGesture {
                                withAnimation {
                                    viewModel.selectedDay = day
                                }
                            }
                        }
                    }
                }
            }
            .padding(.vertical)
            
            HStack {
                Text(viewModel.selectedDay.extractDate(format: "MMMM  EE dd"))
                    .padding(.horizontal)
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
                
                AddButton {
                    
                }
                .padding(.horizontal)
            }
                
            ScrollView {
                if viewModel.eventForToday.isEmpty {
                    
                } else {
                    ForEach(viewModel.eventForToday, id: \.self) {
                        EventCard(event: $0)
                    }
                }
            }
        }
    }
}

struct EventCard: View {
    let event: Event
    
    var body: some View {
        OptionsCard(title: "") {
            HStack {
                VStack {
                    Image(systemName: "ellipsis")
                    Image(systemName: "ellipsis")
                }
                .frame(width: 0)
                .foregroundStyle(.secondaryText.opacity(0.4))
                .font(.system(size: 20))
                .rotationEffect(Angle(degrees: 90))
                .padding()
                
                VStack {
                    Text("12:00")
                        .foregroundStyle(.primaryText)
                        .font(.system(size: 14, weight: .semibold))
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.secondaryText.opacity(0.06))
                        )
                    
                    Rectangle()
                        .frame(width: 2)
                        .foregroundColor(.secondaryText.opacity(0.1))
                }
                .padding(.vertical)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(event.title)
                            .font(.system(size: 18, weight: .semibold))
                        
                        Spacer()
                        
                        Image(systemName: "trash.fill")
                            .foregroundColor(.secondaryText.opacity(0.6))
                            .padding(.horizontal, 12)
                    }
                    
                    Text(event.location)
                        .font(.system(size: 14))
                        .foregroundColor(.secondaryText)
                    
                    HStack {
                        Image(systemName: "clock.fill")
                        Text("2h30m")
                    }
                    .foregroundStyle(.secondaryText)
                    .font(.system(size: 10, weight: .semibold))
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.secondaryText.opacity(0.06))
                    )
                }
                .padding(.leading, 8)
                .padding(.vertical)
            }
            .padding(5)
        }
        .padding(10)
    }
}

#Preview {
    CalendarScreen(viewModel: CalendarViewModel())
        .environment(AppState())
}
