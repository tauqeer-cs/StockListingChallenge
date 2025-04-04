//
//  StockDetailViewModelTests.swift
//  MoneyBaseStockListingChallenge
//
//  Created by Tauqeer on 04/04/25.
//


import XCTest
@testable import MoneyBaseStockListingChallenge
import Combine

final class StockDetailViewModelTests: XCTestCase {

    var viewModel: StockDetailViewModel!
    var mockRepository: StockRepository!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        mockRepository = StaticStockRepository()
        viewModel = StockDetailViewModel(stockRepository: mockRepository)
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
            
        viewModel.loadStockDetail(symbol: "AMRN")
            
        viewModel.$stockDetail
                .dropFirst()
                .sink { stock in
                    // Then
                    XCTAssertNotNil(stock)
                    XCTAssertEqual(stock?.symbol, "AMRN")
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
        viewModel = StockDetailViewModel(stockRepository: failingRepository)
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                if let errorMessage = errorMessage {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        viewModel.loadStockDetail(symbol: "AMRN")
        
        // Then
        wait(for: [expectation], timeout: 1.0)

        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }
    

}