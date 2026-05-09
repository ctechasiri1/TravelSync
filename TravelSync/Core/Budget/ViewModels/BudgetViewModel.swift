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
    var expenses: [Expense] = []
    var showAddExpense: Bool = false
    
    private let expenseService: ExpenseServiceProtocol
    private let tripId: Int
    
    init(tripId: Int, expenseService: ExpenseServiceProtocol) {
        self.tripId = tripId
        self.expenseService = expenseService
    }
    
    var categorySums: [String: Int] {
        var expenseDict: [String: Int] = [:]
        for expense in expenses {
            expenseDict[expense.type.title, default: 0] += expense.amount
        }
        return expenseDict
    }
    
    func getCategorySum(categoryType: String) -> Int {
        guard let categorySum = categorySums[categoryType] else {
            return 0
        }
        return categorySum
    }

    func getExpenses() async -> Void {
        do {
            let expenses = try await expenseService.getExpenses(tripId: tripId)
            await MainActor.run {
                for expenseDTO in expenses {
                    let expenseDomain = Expense(
                        id: expenseDTO.id,
                        title: expenseDTO.title,
                        amount: expenseDTO.amount,
                        transactionDate: expenseDTO.transactionDate,
                        type: ExpenseOption(fromRawValue: expenseDTO.categoryId)
                    )
                    self.expenses.append(expenseDomain)
                }
            }
        } catch let error as APIError {
            print("There was a network error: \(error).")
        } catch {
            print("There was an unexpected error.")
        }
    }
}
