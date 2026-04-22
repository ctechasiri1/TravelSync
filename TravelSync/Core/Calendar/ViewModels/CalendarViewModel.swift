//
//  CalendarViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/19/26.
//

import Observation
import Foundation

@Observable
class CalendarViewModel {
    var selectedDay: Date = Date()
    var currentWeek: [Date] = []
    var events: [Event] = Event.example
    
    init() {
        fetchCurrentWeek()
    }
    
    var eventForToday: [Event] {
        let calendar = Calendar.current
        
        return events.filter({ calendar.isDate($0.date, inSameDayAs: selectedDay) })
    }
    
    func isSelectDay(date: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date, inSameDayAs: selectedDay)
    }
    
    func fetchCurrentWeek() -> Void {
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstDayOfWeek = week?.start else {
            return
        }
        
        (1...30).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstDayOfWeek) {
                currentWeek.append(weekDay)
            }
        }
    }
}
