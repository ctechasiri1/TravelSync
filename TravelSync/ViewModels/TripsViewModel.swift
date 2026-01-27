//
//  TripsViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//

import Observation
import Foundation

@Observable
class TripsViewModel {
    var selection: TripOption = .upcoming
    let trips: [Trip] = [
        Trip(location: "Tokyo, Japan", startDate: "02/05/2026", endDate: "02/15/2026"),
        Trip(location: "Bangkok, Thailand", startDate: "03/05/2026", endDate: "03/15/2026"),
        Trip(location: "Los Angeles, California", startDate: "03/05/2026", endDate: "03/15/2026")
    ]
}
