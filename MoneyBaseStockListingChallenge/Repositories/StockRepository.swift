//
//  StockRepository.swift
//  MoneyBaseStockListingChallenge
//
//  Created by Tauqeer on 03/04/25.
//
import Combine

protocol StockRepository {
    func fetchStocks(region: String) -> AnyPublisher<MarketSummaryResponse, APIError>
}

class MarketStockRepository : StockRepository {

    private let apiClient : APIClientProtocal
    
    init(apiClient: APIClientProtocal = ApiClientRepository()) {
        self.apiClient = apiClient
    }
    
    func fetchStocks(region: String = "US") -> AnyPublisher<MarketSummaryResponse, APIError> {
        return apiClient.request(endPoint: "/market/v2/get-summary", queryItems: [.init(name: "region", value: region)])
    }
    
}

struct MarketSummaryResponse : Decodable {
    let marketSummaryAndSparkResponse: MarketSummaryAndSparkResponse
    
}

struct MarketSummaryAndSparkResponse: Decodable {
    let result: [MarketSummary]
    let error: String?
}


struct MarketSummary: Decodable, Identifiable {
    
    let fullExchangeName: String
    let symbol: String
    var id: String { symbol }
}

