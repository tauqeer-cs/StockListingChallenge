//
//  StockDetailView.swift
//  MoneyBaseStockListingChallenge
//
//  Created by Tauqeer on 03/04/25.
//

import SwiftUI

struct StockDetailView: View {
    
    let summaryObject : MarketSummary
    
    @StateObject private var viewModel = StockDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()
                } else if let _ = viewModel.errorMessage {
                    
                    ///For detail view error we are showing a fallback view
                    StockRowView(stock: summaryObject)
                    Divider()
                    HStack {
                        Text("Exchange Timezone")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        Spacer()
                        Text(summaryObject.exchangeTimezoneName)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                    }
                    Divider()
                    HStack {
                        Text("Price Hit")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(summaryObject.priceHint)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Divider()
                    HStack {
                        Text("Market State")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(summaryObject.marketState)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Divider()
                 
                } else if let stockDetail = viewModel.stockDetail {
                    stockHeader(stockDetail)
                    Divider()
                    stockPriceSection(stockDetail)
                    Divider()
                    stockFinancialsSection(stockDetail)
                    Divider()
                    stockInfoSection(stockDetail)
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.stockDetail?.quoteType.shortName ?? summaryObject.symbol)
        .onAppear {
            viewModel.loadStockDetail(symbol: summaryObject.symbol)
        }
    }
    
    private func stockHeader(_ stockDetail: StockDetailResponse) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(stockDetail.quoteType.longName ?? stockDetail.quoteType.shortName)
                .font(.title2)
                .fontWeight(.bold)
            
            HStack {
                Text(stockDetail.quoteType.exchange)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("Symbol: \(summaryObject.symbol)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private func stockPriceSection(_ stockDetail: StockDetailResponse) -> some View {
        VStack(spacing: 16) {
            HStack(alignment: .firstTextBaseline) {
                Text(stockDetail.price?.regularMarketPrice?.fmt ?? "-")
                    .font(.title)
                    .fontWeight(.bold)
                
                if let change = stockDetail.price?.regularMarketChange?.raw,
                   let _ = stockDetail.price?.regularMarketChangePercent?.raw {
                    HStack(spacing: 4) {
                        Image(systemName: change >= 0 ? "arrow.up" : "arrow.down")
                        Text("\(stockDetail.price?.regularMarketChange?.fmt ?? "-") (\(stockDetail.price?.regularMarketChangePercent?.fmt ?? "-"))")
                    }
                    .foregroundColor(change >= 0 ? .green : .red)
                    .font(.headline)
                }
            }
            
            HStack {
                DetailItemView(title: "Previous Close", value: stockDetail.price?.regularMarketPreviousClose?.fmt ?? "-")
                Spacer()
                DetailItemView(title: "Open", value: stockDetail.price?.regularMarketPrice?.fmt ?? "-")
            }
            
            HStack {
                DetailItemView(title: "Day's Range", value: "\(stockDetail.price?.regularMarketDayLow?.fmt ?? "-") - \(stockDetail.price?.regularMarketDayHigh?.fmt ?? "-")")
                Spacer()
                DetailItemView(title: "Volume", value: stockDetail.price?.regularMarketVolume?.fmt ?? "-")
            }
        }
    }
    
    private func stockFinancialsSection(_ stockDetail: StockDetailResponse) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Key Statistics")
                .font(.headline)
            
            VStack(spacing: 12) {
                HStack {
                    DetailItemView(title: "Revenue", value: stockDetail.financialData?.totalRevenue?.fmt ?? "-")
                    Spacer()
                    DetailItemView(title: "EBITDA", value: stockDetail.financialData?.ebitda?.fmt ?? "-")
                }
            }
        }
    }
    
    private func stockInfoSection(_ stockDetail: StockDetailResponse) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            if let sector = stockDetail.summaryProfile?.sector,
               let industry = stockDetail.summaryProfile?.industry {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Company Info")
                        .font(.headline)
                    
                    HStack {
                        DetailItemView(title: "Sector", value: sector)
                        Spacer()
                        DetailItemView(title: "Industry", value: industry)
                    }
                }
                
                if let website = stockDetail.summaryProfile?.website {
                    Link(destination: URL(string: website) ?? URL(string: "https://www.apple.com")!) {
                        Text("Visit Website")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
            }
            
            if let businessSummary = stockDetail.summaryProfile?.longBusinessSummary {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Business Summary")
                        .font(.headline)
                    
                    Text(businessSummary)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct DetailItemView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.subheadline)
        }
    }
}
