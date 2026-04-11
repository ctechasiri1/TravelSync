//
//  BudgetViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/6/26.
//

import Observation
import Foundation

@Observable
class BudgetViewModel {
    var currentSpending: Int = 0
    var expenseAmount: String = ""
    var selectedExpense: ExpenseOption = .resturant
    var expenses: [Expense] = [Expense.example]
    var showAddExpense: Bool = false
    var transactionDate: Date? = nil
    var notes: String = ""
}
