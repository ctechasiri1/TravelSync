//
//  ExpenseCreateRequest.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/25/26.
//

import Foundation

/// Parameters
///```
///    title: String
///    amount: Int
///    transactionDate: Date
///    categoryId: Int
///    tripId: Int
///```
struct ExpenseCreateRequest {
    let title: String
    let amount: Int
    let transactionDate: Date
    let categoryId: Int
    let tripId: Int
    let receiptImageData: Data?
}
