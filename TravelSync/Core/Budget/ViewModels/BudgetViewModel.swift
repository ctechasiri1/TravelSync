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
    var expenses: [Expense] = [Expense.example]
    var showAddExpense: Bool = false
}
