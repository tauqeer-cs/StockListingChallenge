//
//  MarketSummaryResponse.swift
//  MoneyBaseStockListingChallenge
//
//  Created by Tauqeer on 03/04/25.
//


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
    let shortName: String
    var id: String { symbol }
    let regularMarketPreviousClose: ValueWrapper?
    let regularMarketPrice: ValueWrapper?
    
    var priceChange: Double {
        guard let currentPrice = regularMarketPrice?.raw,
              let previousClose = regularMarketPreviousClose?.raw else {
            return 0.0
        }
        return currentPrice - previousClose
    }
    
    var percentChange: Double {
        guard let previousClose = regularMarketPreviousClose?.raw, previousClose != 0 else {
            return 0.0
        }
        return (priceChange / previousClose) * 100
    }
    
}

struct ValueWrapper: Codable {
    let raw: Double
    let fmt: String
}

