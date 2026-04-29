//
//  ExpenseError.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/29/26.
//

import Foundation

enum ExpenseError: Error {
    case invalidExpense
    case invalidDate
    
    var errorDescription: String {
        switch self {
        case .invalidExpense:
            return "The expense input is either in the incorrect format or empty."
        case .invalidDate:
            return "There was no date selected."
        }
    }
}
