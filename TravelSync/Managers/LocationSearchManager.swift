//
//  LocationSearchManager.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/18/26.
//

import MapKit
import Observation
import Foundation

enum LocationSearchScope {
    case citiesAndCountries, addresses
}

@MainActor
@Observable
final class LocationSearchManager: NSObject, MKLocalSearchCompleterDelegate {
    var suggestions: [MKLocalSearchCompletion] = []
    var selectedItem: MKMapItem?
    
    private let completer = MKLocalSearchCompleter()
    
    init(scope: LocationSearchScope = .citiesAndCountries) {
        super.init()
        completer.delegate = self
        
        switch scope {
        case .citiesAndCountries:
            completer.resultTypes = [.address]
        case .addresses:
            completer.resultTypes = [.address, .pointOfInterest]
        }
    }
    
    // calls suggestions when they are ready then rerendered
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        suggestions = completer.results
    }
    
    func updateQuery(_ query: String) {
        if query.isEmpty {
            suggestions = []
        } else {
            completer.queryFragment = query
        }
    }
    
    func selectSuggestion(_ suggestion: MKLocalSearchCompletion) async {
        let request = MKLocalSearch.Request(completion: suggestion)
        guard let item = try? await MKLocalSearch(request: request).start().mapItems.first else { return }
        selectedItem = item
        suggestions = []
    }
}
