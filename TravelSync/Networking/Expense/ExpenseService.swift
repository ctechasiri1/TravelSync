//
//  ExpenseService.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/25/26.
//

import Foundation
import UIKit

final class ExpenseService: ExpenseServiceProtocol {
    private let networkService: NetworkRequestService
    private let keychainService: KeychainService
    
    init(networkService: NetworkRequestService, keychainService: KeychainService) {
        self.networkService = networkService
        self.keychainService = keychainService
    }
    
    func getExpenses(tripId: Int, expense: ExpenseCreateRequest) async throws -> ExpensePrivateResponse {
        let boundary = "Boundary-\(UUID().uuidString)"
        let isoForamtter = ISO8601DateFormatter()
        
        guard let url = URL(string: "/api/trips/\(tripId)/expense") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
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
}
