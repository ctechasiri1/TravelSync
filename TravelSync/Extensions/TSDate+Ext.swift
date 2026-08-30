//
//  TSDate+Ext.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/7/26.
//

import Foundation

extension Date {
    /// A localized string representing the hour and minute of the date.
    ///```
    /// For example, `05:13:00` becomes `"5:13 AM"` (or `"05:13"` based on the user's 24-hour time setting).
    ///```
    var formattedHourAndMinute: String { self.formatted(.dateTime.hour().minute()) }
    
    /// A localized string representing the month and day of the date.
    ///```
    /// For example, `2026-05-12` becomes `"May 12"` (or the equivalent in the user's current locale).
    ///```
    var formattedMonthAndDay: String { self.formatted(.dateTime.month().day()) }
    
    /// A localized string representing the date in an abbreviated format.
    ///```
    /// For example, `2026-05-12` becomes `"May 12, 2026"` (or the equivalent in the user's locale).
    ///```
    var formattedAbbreviatedDate: String { self.formatted(date: .abbreviated, time: .omitted) }
    
    /// A localized string representing the date in a numeric format.
    ///```
    /// For example, `2026-05-12` becomes `"5/12/26"` (or `"12/05/2026"` depending on the user's region settings).
    ///```
    var formattedNumericDate: String { self.formatted(date: .numeric, time: .omitted) }
    
    /// A localized string representing the date numerically and the time shortened.
    ///```
    /// For example, `2026-05-12T16:00:00Z` becomes `"5/12/26, 4:00 PM"` (or `"12/5/26, 16:00"` depending on device settings).
    ///```
    var formattedNumericDateAndTime: String { self.formatted(date: .numeric, time: .shortened) }
    
    /// A localized string representing the complete date, including the day of the week.
    ///```
    /// For example, `2026-05-12` becomes `"Tuesday, May 12, 2026"` (or the equivalent in the user's locale).
    ///```
    var formattedYearMonthAndDayComplete: String { self.formatted(date: .complete, time: .omitted) }
    
    /// A localized string representing the date in an abbreviated format (year, month, and day).
    ///```
    /// For example, `2026-08-26` becomes `"Aug 26, 2026"` (or the equivalent in the user's locale).
    ///```
    var formattedYearMonthAndDayAbbreviated: String { self.formatted(date: .abbreviated, time: .omitted) }
    
    /// A localized string representing only the day of the month as a number.
    ///```
    /// A localized string representing only the day of the month as a number.
    ///```
    var formattedDay: String { self.formatted(.dateTime.day()) }
    
    /// A localized string representing the abbreviated day of the week.
    ///```
    /// For example, `2026-08-26` becomes `"Wed"`.
    ///```
    var formattedWeekday: String { self.formatted(.dateTime.weekday()) }
    
    /// A localized string representing the full year.
    ///```
    /// For example, `2026-08-26` becomes `"2026"`.
    ///```
    var formattedYear: String { self.formatted(.dateTime.year()) }
    
    /// A localized string representing the shortened time, omitting the date.
    ///```
    /// For example, `2026-08-28T14:00:00Z` becomes `"2:00 PM"`.
    ///```
    var formattedShortenedTime: String { self.formatted(date: .omitted, time: .shortened)}
    
    /// Returns whether the Date falls on today's calendar day
    ///```
    /// Convert 2026-04-08 (if today is April 8) to true
    ///```
    func isToday() -> Bool { Calendar.current.isDateInToday(self) }
    
    /// Returns a localized string representing the duration between this date and an end date.
    ///```
    /// For example, if the current date is 1:00 PM and the end date is 2:30 PM, this returns `"1 hr, 30 min"`.
    ///```
    func formattedDuration(to endTime: Date) -> String {
        let startTime = min(self, endTime)
        let endTime = max(self, endTime)
        
        return (startTime..<endTime).formatted(.components(style: .abbreviated))
    }
    
    /// Returns a localized string representing the date interval between this date and an end date.
    ///```
    /// For example, if this date is April 2, 2026, and the end date is April 5, 2026, this returns `"Apr 2 - 5, 2026"`.
    ///```
    func formattedDateRange(to endDate: Date) -> String {
        let start = min(self, endDate)
        let end = max(self, endDate)
        
        return (start..<end).formatted(date: .abbreviated, time: .omitted)
    }
    
    /// A localized string representing the relative calendar time between this date and a reference date.
    ///```
    /// For example, `2026-06-01` relative to `2026-04-08` returns `"in 2 months"`.
    ///```
    func relativeCalendarDescription(relativeTo referenceDate: Date = .now) -> String {
        let calendar = Calendar.current
        
        let startOfTarget = calendar.startOfDay(for: self)
        let startOfRef = calendar.startOfDay(for: referenceDate)
        
        let formatter = RelativeDateTimeFormatter()
        
        formatter.dateTimeStyle = .named
        
        return formatter.localizedString(for: startOfTarget, relativeTo: startOfRef)
    }
}

