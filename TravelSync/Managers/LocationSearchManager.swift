//
//  LocationSearchManager.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/19/26.
//

import MapKit
import Observation
import Foundation

@Observable
final class LocationSearchManager: NSObject, MKLocalSearchCompleterDelegate {
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
        completions = completer.results.map { SearchCompletions(title: $0.title, subTitle: $0.subtitle) }
    }
    
    func search(with query: String, coordinate: CLLocationCoordinate2D? = nil) async throws -> [SearchResult] {
        let mapKitRequset = MKLocalSearch.Request()
        mapKitRequset.naturalLanguageQuery = query
        mapKitRequset.resultTypes = .address

        if let coordinate {
            mapKitRequset.region = MKCoordinateRegion(MKMapRect(origin: MKMapPoint(coordinate), size: MKMapSize(width: 1, height: 1)))
        }
        
        let search = MKLocalSearch(request: mapKitRequset)
        
        let response = try await search.start()
        
        return response.mapItems.compactMap { SearchResult(location: $0.location.coordinate) }
    }
}
