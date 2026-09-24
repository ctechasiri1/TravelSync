//
//  TSNetworkRequestService.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/25/26.
//

import Foundation

struct TSNetworkRequestService: Sendable {
    
    func sendRequest<Output: Decodable>(request: URLRequest, responseType: Output.Type) async throws -> Output {
        do {
            /// this sends the data to FastAPI then waits for a response
            let (data, response) = try await URLSession.shared.data(for: request)
            
            /// checks the response (convert it to HTTPURLResponse type) making sure it has a successful status code
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse(try JSONDecoder().decode(ErrorResponse.self, from: data))
            }
            
            /// decode it to the DTO (UserPrivateResponse)
            if httpResponse.statusCode == 204 {
                if let empty = EmptyResponse() as? Output {
                    return empty
                }
            }
            
            return try JSONDecoder().decode(responseType, from: data)
        } catch let error as URLError {
            throw APIError.networkError(error)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        }
    }
    
    func createRequest<T: Codable>(url: URL, httpMethod: TSHTTPMethod, valueType: TSHeaderValueType?, httpField: TSHeaderHTTPField?, body: T) throws -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if let valueType = valueType, let httpField = httpField {
            request.setValue(valueType.rawValue, forHTTPHeaderField: httpField.rawValue)
        }
        
        request.httpBody = try JSONEncoder().encode(body)
        
        return request
    }
}
