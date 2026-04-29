//
//  ExpenseServiceProtocol.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/25/26.
//

import Foundation

protocol ExpenseServiceProtocol {
    func createExpense(tripId: Int, expense: ExpenseCreateRequest) async throws -> ExpensePrivateResponse
    func getExpenses(tripId: Int) async throws -> [ExpensePrivateResponse]
}
