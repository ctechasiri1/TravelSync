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
    var expenseAmount: String = ""
    var selectedExpense: ExpenseOption = .resturant
    var transactionDate: Date? = nil
    var notes: String = ""
    
    var isExpenseInputValid: Bool = true
    
    private let expenseService: ExpenseServiceProtocol
    private let loadingManager: LoadingManager
    
    init(expenseService: ExpenseServiceProtocol, loadingManager: LoadingManager) {
        self.expenseService = expenseService
        self.loadingManager = loadingManager
    }
    
    var enableSave: Bool {
        return !expenseAmount.isEmpty && transactionDate != nil && !notes.isEmpty && isExpenseInputValid
    }
    
    func selectExpense(expense: ExpenseOption) {
        selectedExpense = expense
    }
    
    func createExpense(tripId: Int) async -> Void {
        defer { loadingManager.hide() }
        
        loadingManager.show()
        
        do {
            guard let expenseAmount = Int(expenseAmount) else {
                throw ExpenseError.invalidExpense
            }
            
            guard let transactionDate = transactionDate else {
                throw ExpenseError.invalidDate
            }
            
            let _ = try await (Task.sleep(nanoseconds: 500_000_000), expenseService.createExpense(
                expense: ExpenseCreateRequest(
                    title: notes,
                    amount: expenseAmount,
                    transactionDate: transactionDate,
                    categoryId: selectedExpense.id,
                    tripId: tripId,
                    receiptImageData: nil
                )
            )
            )
        } catch ExpenseError.invalidExpense {
            isExpenseInputValid = false
            print(ExpenseError.invalidExpense.errorDescription)
        } catch ExpenseError.invalidDate {
            print(ExpenseError.invalidDate.errorDescription)
        } catch let error as APIError {
            print("There was a network error: \(error).")
        } catch {
            print("There was an unexpected error.")
        }
    }
}
