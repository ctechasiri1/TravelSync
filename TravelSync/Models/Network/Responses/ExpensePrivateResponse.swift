//
//  ExpensePrivateResponse.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/25/26.
//

import Foundation

struct ExpensePrivateResponse: Codable {
    let title: String
    let amount: Int
    let transactionDate: Date
    let categoryId: Int
    let id: Int
    let tripId: Int
    let receiptImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case amount
        case transactionDate = "transaction_date"
        case categoryId = "category_id"
        case id
        case tripId = "trip_id"
        case receiptImageUrl = "receipt_image_url"
    }
}
