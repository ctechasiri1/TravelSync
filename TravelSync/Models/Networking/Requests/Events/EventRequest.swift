//
//  EventRequest.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/28/26.
//

import Foundation

struct EventRequest {
    let id: Int
    let title: String
    let location: String
    let longitude: Double
    let latitude: Double
    let date: Date
    let startTime: Date
    let endTime: Date
}
