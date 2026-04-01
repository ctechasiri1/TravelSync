////
////  TripTestService.swift
////  TravelSync
////
////  Created by Chiraphat Techasiri on 3/31/26.
////
//
//import Foundation
//
//final class TripTestService: TripServiceProtocol {
//    func createTrip(trip: TripCreateRequest) async throws -> TripPrivateResponse {
//        return TripPrivateResponse(
//            id: "1",
//            tripName: "Mango Sticky Rice Summer",
//            location: "Bangkok, Thailand",
//            budget: "5000",
//            startDate: .now,
//            endDate: .now,
//            imageURLString: ""
//        )
//    }
//    
//    func getTrip() async throws -> [TripPrivateResponse] {
//        return [
//            TripPrivateResponse(
//                id: "1",
//                tripName: "Summer in Thailand",
//                location: "Bangkok, Thailand",
//                budget: "1_000",
//                startDate: Calendar.current.date(byAdding: .day, value: 2, to: Date.now) ?? .now,
//                endDate: Calendar.current.date(byAdding: .day, value: 3, to: Date.now) ?? .now,
//                imageURLString: ""
//            ),
//            TripPrivateResponse(
//                id: "2",
//                tripName: "Eating Pho in Vietnam",
//                location: "Saigon, Vietnam",
//                budget: "2_000",
//                startDate: Calendar.current.date(byAdding: .day, value: -7, to: Date.now) ?? .now,
//                endDate: Calendar.current.date(byAdding: .day, value: -5, to: Date.now) ?? .now,
//                imageURLString: ""
//            ),
//            TripPrivateResponse(
//                id: "3",
//                tripName: "Bubble Tea in Taiwan",
//                location: "Taipei, Taiwan",
//                budget: "3_000",
//                startDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now) ?? .now,
//                endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date.now) ?? .now,
//                imageURLString: ""
//            )
//        ]
//    }
//}
