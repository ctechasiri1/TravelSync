//
//  Expense.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/7/26.
//

import Foundation

struct Expense: Identifiable {
    let id: Int
    let title: String
    let amount: Int
    let transactionDate: Date
    let type: ExpenseOption
    
    @MainActor
    static var example: Expense {
        return Expense(
            id: 1,
            title: "Dinner in Gion",
            amount: 30,
            transactionDate: .now,
            type: .activities
        )
    }
}
