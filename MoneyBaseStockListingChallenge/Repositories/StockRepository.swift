//
//  StockRepository.swift
//  MoneyBaseStockListingChallenge
//
//  Created by Tauqeer on 03/04/25.
//
import Combine
import Foundation

protocol StockRepository {
    func fetchStocks(region: String) -> AnyPublisher<MarketSummaryResponse, APIError>
    func getStockDetails(symbol : String,region: String) -> AnyPublisher<StockDetailResponse, APIError>
}

class MarketStockRepository : StockRepository {
    
    private let apiClient : APIClientProtocal
    
    init(apiClient: APIClientProtocal = ApiClientRepository()) {
        self.apiClient = apiClient
    }
    
    func fetchStocks(region: String = "US") -> AnyPublisher<MarketSummaryResponse, APIError> {
        return apiClient.request(endPoint: "/market/v2/get-summary", queryItems: [.init(name: "region", value: region)])
    }
    
    ///According to the documentation from the https://rapidapi.com/apidojo/ap this is already depricated
    ///So this will actually always return 204 , no data
    ///So the whereever we are using it should have to check 204 and show a fallback view
    func getStockDetails(symbol: String = "US", region: String) -> AnyPublisher<StockDetailResponse, APIError> {
        let queryItems : [URLQueryItem] = [
            .init(name: "symbol", value: symbol),
            .init(name: "region", value: region)
        ]
        return apiClient.request(endPoint: "/stock/v2/get-summary", queryItems: queryItems)
    }
}


