//
//  StockListingView.swift
//  MoneyBaseStockListingChallenge
//
//  Created by Tauqeer on 03/04/25.
//

import SwiftUI

struct StockListingView: View {
    
    @StateObject private var viewModel: StockListViewModel = StockListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                
                if viewModel.isLoading && viewModel.stocks.isEmpty {
                    LoadingShimmerView()
                } else if let errorMessage = viewModel.errorMessage,viewModel.stocks.isEmpty {
                    ErrorView(message: errorMessage) {
                        viewModel.loadMarketSummary()
                    }
                } else {
                    stockList
                }
            }
            .navigationTitle("Top Stocks")

        }
        .searchable(text: $viewModel.searchText , prompt: "Search")

    }
    
    private var stockList: some View {
        List {
            ForEach(viewModel.filteredStocks) { stock in
                NavigationLink(destination: StockDetailView(summaryObject: stock)) {
                    StockRowView(stock: stock)
                }
            }
        }
        .listStyle(PlainListStyle())
        .refreshable {
            viewModel.loadMarketSummary()
        }
    }
    
}

struct StockRowView: View {
    let stock: MarketSummary
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(stock.shortName)
                    .font(.headline)
                
                Text(stock.symbol)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(stock.regularMarketPrice?.fmt ?? "-")
                    .font(.headline)
                
                HStack(spacing: 2) {
                    Image(systemName: stock.priceChange >= 0 ? "arrow.up" : "arrow.down")
                        .foregroundColor(stock.priceChange >= 0 ? .green : .red)
                    
                    Text("\(String(format: "%.2f", abs(stock.priceChange))) (\(String(format: "%.2f", abs(stock.percentChange)))%)")
                        .font(.subheadline)
                        .foregroundColor(stock.priceChange >= 0 ? .green : .red)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    StockListingView()
}

struct LoadingShimmerView : View {
    var body: some View {
        List {
            ForEach(0..<8, id: \.self) { _ in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Long Company Name")
                            .font(.headline)
                            .shimmer(isActive: true)
                        
                        Text("SYM $54")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .shimmer(isActive: true)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("5416423.00")
                            .font(.headline)
                            .shimmer(isActive: true)
                        
                        Text("16123.75")
                                .font(.subheadline)
                                .foregroundColor(.red)
                                .shimmer(isActive: true)
                        
                    }
                }
                .padding(.horizontal)
            }
        }
        .listStyle(PlainListStyle())
    }
}
struct ErrorView: View {
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            Text(message)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            Button("Retry") {
                retryAction()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            Spacer()
        }
        .padding()
    }
}

