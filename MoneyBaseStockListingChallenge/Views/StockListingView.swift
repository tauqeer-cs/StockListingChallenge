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
                    LoadingView()
                } else if let errorMessage = viewModel.errorMessage,viewModel.stocks.isEmpty {
                    ErrorView(message: errorMessage) {
                        viewModel.loadMarketSummary()
                    }
                } else {
                    stockList
                }
            }
        }
    }
    
    private var stockList: some View {
        List {
            ForEach(viewModel.filteredStocks) { stock in
                
                //Add Navigation Link here later
                StockRowView(stock: stock)
                
            }
        }
        .listStyle(PlainListStyle())
        .refreshable {
            viewModel.loadMarketSummary()
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
            }
            .padding(.vertical, 4)
        }
    }
    
}

#Preview {
    StockListingView()
}

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading market data...")
                .font(.headline)
                .padding()
            Spacer()
        }
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

