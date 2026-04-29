//
//  AddExpenseViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/28/26.
//

import Observation
import Foundation

@Observable
class AddExpenseViewModel {
    var currentSpending: Int = 0
    var expenseAmount: String = ""
    var selectedExpense: ExpenseOption = .resturant
    var transactionDate: Date? = nil
    var notes: String = ""
    
    private let expenseService: ExpenseServiceProtocol
    
    init(expenseService: ExpenseServiceProtocol) {
        self.expenseService = expenseService
    }
}
