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
    
    private static let directionalTimeFormatter: RelativeDateTimeFormatter = {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            formatter.dateTimeStyle = .named
            
            return formatter
    }()
    
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
    
    /// Converts a Date into a highly accurate relative time String based on human calendar rules
    ///```
    /// Convert June 1 (from April 8) to "in 2 months"
    /// Convert May 2 (from April 8) to "in 3 weeks"
    /// Convert exactly today to "today"
    ///```
    func dateToDifferenceString(relativeTo referenceDate: Date = .now) -> String {
        let calendar = Calendar.current
            
        // 1. Strip the time out so we are only comparing pure calendar days
        let startOfRef = calendar.startOfDay(for: referenceDate)
        let startOfTarget = calendar.startOfDay(for: self)
            
        // 2. Get exact days between dates
        let days = calendar.dateComponents(
            [.day],
            from: startOfRef,
            to: startOfTarget
        ).day ?? 0
            
        // 3. Handle exact day names natively so we don't rely on the formatter for these
        if days == 0 { return "today" }
        if days == 1 { return "tomorrow" }
        if days == -1 { return "yesterday" }
            
        let absDays = abs(days)
        var componentsToFormat = DateComponents()
            
        // 4. Force the boundaries manually!
        if absDays < 7 {
            // Less than a week -> Use days (e.g. "in 5 days", "3 days ago")
            componentsToFormat.day = days
                
        } else if absDays < 30 {
            // 1 to 4 weeks -> Use weeks (e.g. "in 3 weeks")
            // (Using .weekOfMonth fixes the blank text bug!)
            componentsToFormat.weekOfMonth = days / 7
                
        } else if absDays < 365 {
            // Months -> Calculate the EXACT calendar month difference (April to June = 2)
            let refMonth = calendar.component(.month, from: startOfRef)
            let refYear = calendar.component(.year, from: startOfRef)
            let targetMonth = calendar.component(.month, from: startOfTarget)
            let targetYear = calendar.component(.year, from: startOfTarget)
                
            let monthsDiff = (targetYear - refYear) * 12 + (
                targetMonth - refMonth
            )
            componentsToFormat.month = monthsDiff
                
        } else {
            // Years -> Calculate the EXACT calendar year difference
            let yearsDiff = calendar.component(.year, from: startOfTarget) - calendar.component(
                .year,
                from: startOfRef
            )
            componentsToFormat.year = yearsDiff
        }
            
        // 5. Feed the exact, calculated unit into the formatter
        return Date.directionalTimeFormatter
            .localizedString(from: componentsToFormat)
    }
}

