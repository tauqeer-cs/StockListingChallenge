//
//  StockDetailResponse.swift
//  MoneyBaseStockListingChallenge
//
//  Created by Tauqeer on 03/04/25.
//

struct StockDetailResponse: Codable {
    
    let symbol : String
    let quoteType: QuoteType
    let summaryProfile: SummaryProfile?
    let price: Price?
    let financialData: FinancialData?
    let earnings: Earnings?
}

struct QuoteType: Codable {
    let shortName: String
    let longName: String?
    let exchange: String
    let market: String
}

struct SummaryProfile: Codable {
    let sector: String?
    let industry: String?
    let longBusinessSummary: String?
    let website: String?
}

struct Price: Codable {
    let regularMarketPrice: ValueWrapper?
    let regularMarketDayHigh: ValueWrapper?
    let regularMarketDayLow: ValueWrapper?
    let regularMarketVolume: ValueWrapper?
    let regularMarketChange: ValueWrapper?
    let regularMarketChangePercent: ValueWrapper?
    let regularMarketPreviousClose: ValueWrapper?
}

struct FinancialData: Codable {
    let totalRevenue: ValueWrapper?
    let ebitda: ValueWrapper?
    let operatingCashflow: ValueWrapper?
    let profitMargins: ValueWrapper?
    let targetMeanPrice: ValueWrapper?
    let recommendationMean: ValueWrapper?
}

struct Earnings: Codable {
    let earningsChart: EarningsChart?
    let financialsChart: FinancialsChart?
}

struct EarningsChart: Codable {
    let quarterly: [QuarterlyEarning]?
}

struct FinancialsChart: Codable {
    let yearly: [PeriodicFinancial]?
    let quarterly: [PeriodicFinancial]?
}

struct QuarterlyEarning: Codable {
    let date: String
    let actual: ValueWrapper?
    let estimate: ValueWrapper?
}

struct PeriodicFinancial: Codable {
    let date: Int
    let revenue: ValueWrapper?
    let earnings: ValueWrapper?
}



