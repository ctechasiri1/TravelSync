//
//  Trip.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 1/26/26.
//

import Foundation
import PhotosUI

struct Trip: Identifiable {
    let id: UUID = UUID()
    let tripName: String
    let location: String
    let startDate: Date
    let endDate: Date
    let coverImage: UIImage?
}
