//
//  StockDetailViewModel.swift
//  MoneyBaseStockListingChallenge
//
//  Created by Tauqeer on 03/04/25.
//


import Foundation
import Combine

class StockDetailViewModel: ObservableObject {
    @Published var stockDetail: StockDetailResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    private var stockRepository : StockRepository
    
    //To Test the detail with with data we can also make StaticStockRepository() since
    init(stockRepository : StockRepository = MarketStockRepository()){
        self.stockRepository = stockRepository
    }
    
    func loadStockDetail(symbol: String) {
        isLoading = true
        errorMessage = nil
        
        stockRepository.getStockDetails(symbol: symbol, region: "US")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                
                if case .failure(let error) = completion {
                    
                    self?.errorMessage = "Failed to load stock details: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] stockDetail in
                self?.stockDetail = stockDetail
            }
            .store(in: &cancellables)
    }
}
