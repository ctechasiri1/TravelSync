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

struct SearchResult: Identifiable, Hashable {
    let id = UUID()
    let location: CLLocationCoordinate2D
    
    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
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
