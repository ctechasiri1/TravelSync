//
//  Trip.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//

import Foundation

struct Trip: Identifiable {
    let id: UUID = UUID()
    let location: String
    let startDate: String
    let endDate: String
    
    func stringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
    
    func daysTillTrip() -> Int {
        let startDate = stringToDate(dateString: startDate)
        let todayDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: todayDate, to: startDate!)
        return components.day!
    }
}
