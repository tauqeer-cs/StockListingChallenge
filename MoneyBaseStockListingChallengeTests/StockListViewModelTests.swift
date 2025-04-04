//
//  StockListViewModelTests.swift
//  MoneyBaseStockListingChallengeTests
//
//  Created by Tauqeer on 04/04/25.
//

import XCTest
@testable import MoneyBaseStockListingChallenge
import Combine

final class StockListViewModelTests: XCTestCase {

    var viewModel: StockListViewModel!
    var mockRepository: StockRepository!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        mockRepository = StaticStockRepository()
        viewModel = StockListViewModel(stockRepository: mockRepository)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testLoadStocksSuccess() {
            // Given
            let expectation = XCTestExpectation(description: "Stocks loaded")
            
            viewModel.loadMarketSummary()
            
            viewModel.$stocks
                .dropFirst()
                .sink { stocks in
                    // Then
                    XCTAssertEqual(stocks.count, 2)
                    XCTAssertEqual(stocks[0].symbol, "^GSPC")
                    XCTAssertEqual(stocks[1].symbol, "^DJI")
                    expectation.fulfill()
                }
                .store(in: &cancellables)
        
            wait(for: [expectation], timeout: 1.0)
        
            XCTAssertNil(viewModel.errorMessage)
            XCTAssertFalse(viewModel.isLoading)
    }
    
    
    func testLoadStocksFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Error message should be set")
        
        let failingRepository = FailingStockRepository()
        viewModel = StockListViewModel(stockRepository: failingRepository)
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                if let errorMessage = errorMessage, errorMessage.contains("Failed to load market data") {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        viewModel.loadMarketSummary()
        
        // Then
        wait(for: [expectation], timeout: 1.0)

        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }
    

}

class FailingStockRepository: StockRepository {
    func getStockDetails(symbol: String, region: String) -> AnyPublisher<MoneyBaseStockListingChallenge.StockDetailResponse, MoneyBaseStockListingChallenge.APIError> {
        return Fail(error: APIError.invalidResponse)
            .eraseToAnyPublisher()
    }
    
    
    func fetchStocks(region: String) -> AnyPublisher<MarketSummaryResponse, APIError> {
        
        return Fail(error: APIError.invalidResponse)
            .eraseToAnyPublisher()
    }
    
}

