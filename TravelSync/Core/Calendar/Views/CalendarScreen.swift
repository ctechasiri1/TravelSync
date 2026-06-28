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
                
                Text(Date().formattedAbbreviatedDate)
                    .foregroundStyle(.secondaryText.opacity(0.6))
            }
            .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyVStack(spacing: 15) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.currentWeek, id: \.self) { day in
                            VStack {
                                Text(day.formatted(format: "dd"))
                                    .font(.system(size: 15, weight: .semibold))
                                
                                Text(day.formatted(format: "EEE"))
                                    .font(.system(size: 14))
                                
                                Circle()
                                    .fill(.white)
                                    .frame(width: 8, height: 8)
                                    .opacity(viewModel.isSelectDay(date: day) ? 1 : 0)
                            }
                            .foregroundStyle(viewModel.isSelectDay(date: day) ? .white : .secondaryText.opacity(0.5))
                            .frame(width: 70, height: 110)
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
                Text(viewModel.selectedDay.formatted(format: "MMMM, EE dd"))
                    .padding(.horizontal)
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
            }
                
            ScrollView {
                if viewModel.eventForToday.isEmpty {
                    
                } else {
                    VStack(spacing: 0) {
                        ForEach(viewModel.eventForToday, id: \.self) {
                            EventCard(event: $0)
                        }
                    }
                }
            }
        }
    }
}

struct EventCard: View {
    let event: Event
    
    var body: some View {
        HStack {
            HStack {
                VStack {
                    Rectangle()
                        .frame(width: 2)
                        .foregroundColor(.secondaryText.opacity(0.1))
                    
                    Circle()
                        .foregroundStyle(.accentPrimary.opacity(0.8))
                        .frame(width: 50, height: 15)
                        .background(
                            Circle()
                                .fill(.accentPrimary.opacity(0.2))
                                .frame(width: 80, height: 25)
                        )
                    
                    Rectangle()
                        .frame(width: 2)
                        .foregroundColor(.secondaryText.opacity(0.1))
                        .frame(height: 150)
                }
                
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(event.startTime.formatted(date: .omitted, time: .shortened))
                            .foregroundStyle(.primaryText)
                            .font(.system(size: 16))
                            .padding(14)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(.secondaryText.opacity(0.06))
                                    
                            )
                        
                        Image(systemName: event.category.imageName)
                            .foregroundColor(.secondaryText.opacity(0.6))
                        
                        Spacer()
                        
                        Image(systemName: "trash")
                            .foregroundColor(.secondaryText.opacity(0.6))
                            .fontWeight(.semibold)
                            .padding(.horizontal, 12)
                    }
                    
                    HStack {
                        Text(event.title)
                            .font(.system(size: 18, weight: .semibold))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "map")
                        
                        Text(event.location)
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.secondaryText)
                    
                    HStack {
                        Image(systemName: "clock")
                        Text("2h 30m")
                    }
                    .foregroundStyle(.secondaryText)
                    .font(.system(size: 12, weight: .semibold))
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.secondaryText.opacity(0.06))
                    )
                }
                .padding(25)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.white)
                )
                .shadow(color: Color.black.opacity(0.1), radius: 5, y: 2)
                .padding()

            }
        }
    }
}

#Preview {
    CalendarScreen(viewModel: CalendarViewModel())
        .environment(AppState())
}
