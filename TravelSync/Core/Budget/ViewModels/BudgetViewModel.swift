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
    var expenses: [Expense] = [] {
        didSet {
            updateSortedExpenses()
            
        }
    }
    var sortedExpenses: [Expense] = []
//    var dateExpenses: [Date: Expense] = [:]
    var showAddExpense: Bool = false
    var showAllExpense: Bool = false
    
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
    
//    var dateExpenses: [Date: [Expense]] {
//        var dateDict: [Date: [Expense]] = [:]
//        for expense in expenses {
//            if let dateExists = dateDict[expense.transactionDate] {
//                dateExists.append(expense)
//            }
//            dateDict[expense.transactionDate]?.append(<#T##newElement: Expense##Expense#>)
//        }
//    }
//    
    
    
    func updateSortedExpenses() -> Void {
        sortedExpenses = expenses.sorted { $0.transactionDate > $1.transactionDate }
    }
    
    func getCategorySum(categoryType: String) -> Int {
        guard let categorySum = categorySums[categoryType] else {
            return 0
        }
        return categorySum
    }

    func getExpenses() async -> Void {
        do {
            var fetchedExpenses: [Expense] = []
            let expensePayload = try await expenseService.getExpenses(tripId: tripId)
            await MainActor.run {
                for expenseDTO in expensePayload {
                    let expenseDomain = Expense(
                        id: expenseDTO.id,
                        title: expenseDTO.title,
                        amount: expenseDTO.amount,
                        transactionDate: expenseDTO.transactionDate,
                        type: ExpenseOption(fromRawValue: expenseDTO.categoryId)
                    )
                    fetchedExpenses.append(expenseDomain)
                    
                    self.expenses = fetchedExpenses
                }
            }
        } catch let error as APIError {
            print("There was a network error: \(error).")
        } catch {
            print("There was an unexpected error.")
        }
    }
}
