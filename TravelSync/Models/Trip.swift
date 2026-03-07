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
    let startDate: Date
    let endDate: Date
}
