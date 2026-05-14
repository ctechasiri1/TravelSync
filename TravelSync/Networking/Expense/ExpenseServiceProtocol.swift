//
//  ExpenseServiceProtocol.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/25/26.
//

import Foundation

protocol ExpenseServiceProtocol {
    func createExpense(expense: ExpenseCreateRequest) async throws -> ExpensePrivateResponse
    func getExpenses(tripId: Int) async throws -> [ExpensePrivateResponse]
    func deleteExpense(tripId: Int, expenseId: Int) async throws -> EmptyResponse
}
