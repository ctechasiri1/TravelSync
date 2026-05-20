//
//  LocationSearchService.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/19/26.
//

import MapKit
import Observation
import Foundation

struct SearchCompletions: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
}

@Observable
final class LocationSearchService: NSObject, MKLocalSearchCompleterDelegate {
    private let completer: MKLocalSearchCompleter
    var completions = [SearchCompletions]()
    
    init(completer: MKLocalSearchCompleter) {
        self.completer = completer
        super.init()
        self.completer.delegate = self
    }
    
    func update(queryFragement: String) {
        completer.resultTypes = [.address]
        completer.queryFragment = queryFragement
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completions = completer.results.map { .init(title: $0.title, subTitle: $0.subtitle) }
    }
}
