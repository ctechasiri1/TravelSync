//
//  ExpenseService.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/25/26.
//

import Foundation
import UIKit

actor ExpenseService: ExpenseServiceProtocol {
    private let networkService: NetworkRequestManager
    private let keychainService: KeychainManager
    private var activeTask: Task<[ExpensePrivateResponse], Error>?
    
    init(networkService: NetworkRequestManager, keychainService: KeychainManager) {
        self.networkService = networkService
        self.keychainService = keychainService
    }
    
    func createExpense(expense: ExpenseCreateRequest) async throws -> ExpensePrivateResponse {
        let boundary = "Boundary-\(UUID().uuidString)"
        let isoForamtter = ISO8601DateFormatter()
        
        guard let url = URL(string: "http://127.0.0.1:8000/api/trips/\(expense.tripId)/expense") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if let token = keychainService.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        var body = Data()
        
        let fields: [(String, String)] = [
            ("title", expense.title),
            ("amount", String(expense.amount)),
            ("transaction_date", isoForamtter.string(from: expense.transactionDate)),
            ("category_id", String(expense.categoryId)),
            ("tripId", String(expense.tripId))
        ]
        
        for (name, value) in fields {
            body.append(Data("--\(boundary)\r\n".utf8))
            body.append(Data("Content-Disposition: form-data;".utf8))
            body.append(Data("name=\"\(name)\"\r\n\r\n".utf8))
            body.append(Data("\(value)\r\n".utf8))
        }
        
        if let receiptData = expense.receiptImageData {
            body.append(Data("--\(boundary)\r\n".utf8))
            body.append(Data("Content-Disposition: form-data;".utf8))
            body.append(Data("name=\"receipt_image_file\";".utf8))
            body.append(Data("filename=\"receipt.jpg\"\r\n".utf8))
            body.append(Data("Content-Type: image/jpeg\r\n\r\n".utf8))
            body.append(Data(receiptData))
            body.append(Data("\r\n".utf8))
        }
        
        body.append(Data("--\(boundary)--\r\n".utf8))
        
        request.httpBody = body
        
        return try await networkService.sendRequest(request: request, responseType: ExpensePrivateResponse.self)
    }
    
    func getExpenses(tripId: Int) async throws -> [ExpensePrivateResponse] {
        if let existing = activeTask {
            return try await existing.value
        }
        
        let task = Task<[ExpensePrivateResponse], Error> {
            guard let url = URL(string: "http://127.0.0.1:8000/api/trips/\(tripId)/expenses") else {
                throw APIError.invalidURL
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            if let token = keychainService.getToken() {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            return try await networkService.sendRequest(request: request, responseType: [ExpensePrivateResponse].self)
        }
        
        activeTask = task
        
        defer { activeTask = nil }
        
        return try await task.value
    }
    
    func deleteExpense(tripId: Int, expenseId: Int) async throws -> EmptyResponse {
        guard let url = URL(string: "http://127.0.0.1:8000/api/trips/\(tripId)/expense/\(expenseId)") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        if let token = keychainService.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return try await networkService.sendRequest(request: request, responseType: EmptyResponse.self)
    }
}
