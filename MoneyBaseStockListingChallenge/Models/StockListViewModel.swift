//
//  StockListViewModel.swift
//  MoneyBaseStockListingChallenge
//
//  Created by Tauqeer on 03/04/25.
//

import Foundation
import Combine

class StockListViewModel : ObservableObject {
    
    @Published var stocks : [MarketSummary] = []
    @Published var filteredStocks : [MarketSummary] = []
    @Published var searchText : String = ""
    @Published var isLoading : Bool = false
    @Published var errorMessage : String?
    
    private var cancellables : Set<AnyCancellable> = []
    private var refreshTimer : Timer?
    private var stockRepository : StockRepository
    
    init(stockRepository : StockRepository = MarketStockRepository()){
        self.stockRepository = stockRepository
        setupSearchSubscription()
        loadMarketSummary()
        setupRefreshTimer()
    }
    
    deinit {
        refreshTimer?.invalidate()
    }
    
    private func setupSearchSubscription() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.filterStocks(with: searchText)
            }
            .store(in: &cancellables)
    }
    
    private func filterStocks(with searchText: String) {
        if searchText.isEmpty {
            filteredStocks = stocks
        } else {
            filteredStocks = stocks.filter { stock in
                stock.symbol.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func loadMarketSummary() {
        isLoading = true
        errorMessage = nil
        
        stockRepository.fetchStocks(region: "US")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                
                if case .failure(let error) = completion {
                    self?.errorMessage = "Failed to load market data: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] response in
                self?.stocks = response.marketSummaryAndSparkResponse.result
                self?.filterStocks(with: self?.searchText ?? "")
            }
            .store(in: &cancellables)
    }
    
    private func setupRefreshTimer() {
        ///TODO : Change this interval to 8 later
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 800, repeats: true) { [weak self] _ in
            self?.loadMarketSummary()
        }
    }
    
}
