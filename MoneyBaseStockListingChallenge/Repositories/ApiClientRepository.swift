//
//  RestApiRepository.swift
//  MoneyBaseStockListingChallenge
//
//  Created by Tauqeer on 03/04/25.
//

import Foundation
import Combine

enum APIError: Error {
    
    case noData
    case invalidURL
    case invalidResponse
    case networkError(Error)
    case decodingError(Error)
    
}

protocol APIClientProtocal {
    func request<T: Decodable>(endPoint : String,queryItems : [URLQueryItem]) -> AnyPublisher<T, APIError>
}

class ApiClientRepository : APIClientProtocal {
    
    func request<T>(endPoint: String, queryItems: [URLQueryItem]) -> AnyPublisher<T, APIError> where T : Decodable {
        var components = URLComponents(string: ApiConfig.baseUrl + endPoint)
        components?.queryItems = queryItems
        guard let url = components?.url else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        var apiRequest = URLRequest(url: url)
        apiRequest.addValue(ApiConfig.apiHost, forHTTPHeaderField: "x-rapidapi-host")
        apiRequest.addValue(ApiConfig.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        
    
         return URLSession.shared.dataTaskPublisher(for: apiRequest)
            .tryMap { data , urlResponse in
                guard let response = urlResponse as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                
                if response.statusCode == 204 {
                    throw APIError.noData
                } else if response.statusCode != 200 {
                    throw APIError.invalidResponse
                }
                
                return data
            }
            .mapError { error in
                if let apiError = error as? APIError {
                    return apiError
                } else {
                    return APIError.networkError(error)
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in APIError.decodingError(error) }
            .eraseToAnyPublisher()
               
    }
    
}


extension APIError: Equatable {
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.noData, .noData),
             (.invalidURL, .invalidURL),
             (.invalidResponse, .invalidResponse):
            return true
        case (.networkError, .networkError),
             (.decodingError, .decodingError):
            return true
        default:
            return false
        }
    }
}

