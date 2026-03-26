//
//  NetworkRequestManager.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/25/26.
//

import Foundation

final class NetworkRequestManager {
    static let shared = NetworkRequestManager()
    
    private init() { }
    
    // MARK: Sends the request and returns the response from FastAPI
    func sendRequest<Output: Decodable>(requestBody: URLRequest, responseType: Output.Type) async throws -> Output {
        do {
            /// 1. this sends the data to FastAPI then waits for a response
            let (data, response) = try await URLSession.shared.data(for: requestBody)
            
            /// 2. checks the response (convert it to HTTPURLResponse type) making sure it has a successful status code
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            /// 3. decode it to the DTO (UserPrivateResponse)
            return try JSONDecoder().decode(responseType, from: data)
        } catch let error as URLError {
            throw APIError.networkError(error)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        }
    }
}
