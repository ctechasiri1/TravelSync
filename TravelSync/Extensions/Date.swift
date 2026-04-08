//
//  Date.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/7/26.
//

import Foundation

extension Date {
    private static let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .short
        formatter.maximumUnitCount = 2
        
        return formatter
    }()
    
    private static let dateRangeFormatter: DateIntervalFormatter = {
        let formatter = DateIntervalFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter
    } ()
    
    private static let dateDifferenceFormatter: DateComponentsFormatter = {
        let foramtter = DateComponentsFormatter()
        foramtter.allowedUnits = .day
        foramtter.unitsStyle = .full
        
        return foramtter
    } ()
    
    /// Converts a Date into a natural, relative time String
    ///```
    /// Convert exactly now to "Today"
    /// Convert 1 day ago to "yesterday"
    ///```
    var relativeTime: String {
        // 1. Check if the date falls anywhere within the current calendar day
        if Calendar.current.isDateInToday(self) {
            return "Today" // Or String(localized: "Today") if your app supports multiple languages
        }
        
        // 2. If it's not today, let the formatter do its normal job
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.dateTimeStyle = .named
        
        return formatter.localizedString(for: self, relativeTo: Date.now)
    }
    
    /// Converts a Date into a localized time String displaying only the hour and minute
    ///```
    /// Convert 05:13:00 to "5:13 AM" (or "05:13" on 24-hour devices)
    ///```
    var dateToStringHourAndMin: String {
        return self.formatted(.dateTime.hour().minute())
    }

    /// Converts a Date into a localized String displaying only the month and day
    ///```
    /// Convert 2026-04-02 to "Apr 2"
    ///```
    var dateToStringMonthAndDay: String {
        return self.formatted(.dateTime.month().day())
    }
    
    /// Converts the difference between two Dates into a formatted duration String
    ///```
    /// Convert 2 hours and 30 minutes difference to "2 hr, 30 min"
    ///```
    func durationString(to endTime: Date) -> String {
        let timeDifferenceString = Date.durationFormatter.string(from: self, to: endTime)
        return timeDifferenceString ?? "0m"
    }
    
    /// Converts two Dates into a localized date range String
    ///```
    /// Convert April 2 and April 5 to "Apr 2 - 5, 2026"
    ///```
    func dateToStringRange(to endDate: Date) -> String {
        return Date.dateRangeFormatter.string(from: self, to: endDate)
    }
    
    /// Converts the difference between two Dates into a formatted days String
    ///```
    /// Convert a 3-day difference to "3 days"
    ///```
    func dateToDifferenceString(to endDate: Date) -> String {
        return Date.dateDifferenceFormatter.string(from: self, to: endDate) ?? "0 days"
    }
}

