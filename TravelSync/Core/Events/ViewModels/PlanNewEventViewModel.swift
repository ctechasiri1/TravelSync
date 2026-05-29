//
//  PlanNewEventViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/28/26.
//

import Observation
import Foundation
import SwiftUI

@Observable
class PlanNewEventViewModel {
    var eventCoverImage: UIImage?
    var eventName: String = ""
    var location: String = ""
    var completions: [SearchCompletions] = []
    var startTime: Date?
    var endTime: Date?
    var notes: String?
    
    var selectedEvent: EventOption = .dinning
}
