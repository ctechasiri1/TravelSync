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
    var storedEvents: [Event] = []
    var currentWeek: [Date] = []
    
    init() {
        fetchCurrentWeek()
    }
    
    func fetchCurrentWeek() -> Void {
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstDayOfWeek = week?.start else {
            return
        }
        
        (1...7).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstDayOfWeek) {
                currentWeek.append(weekDay)
            }
        }
    }
}
