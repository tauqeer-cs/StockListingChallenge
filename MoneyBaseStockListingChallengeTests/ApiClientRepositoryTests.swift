//
//  ApiClientRepositoryTests.swift
//  MoneyBaseStockListingChallenge
//
//  Created by Tauqeer on 04/04/25.
//


import XCTest
import Combine
@testable import MoneyBaseStockListingChallenge

class ApiClientRepositoryTests: XCTestCase {
    
    var sut: ApiClientRepository!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        sut = ApiClientRepository()
        cancellables = []
    }
    
    override func tearDown() {
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testRequestWithInvalidURLReturnsInvalidURLError() {
        // Given
        let invalidEndpoint = String(repeating: " ", count: 100)
        let expectation = self.expectation(description: "Should return invalidURL error")
        var receivedError: APIError?
        
        // When
        sut.request(endPoint: invalidEndpoint, queryItems: [])
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        receivedError = error
                        expectation.fulfill()
                    }
                },
                receiveValue: { (_: MockResponse) in }
            )
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 1)
        XCTAssertEqual(receivedError, .invalidURL)
    }
    
    func testRequestWithSuccessfulResponseReturnsDecodedData() throws {
        // Given
        let mockURLSession = MockURLSession()
        let mockData = """
        {
            "id": "123",
            "name": "Test Item"
        }
        """.data(using: .utf8)!
        
        let response = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        mockURLSession.mockDataTaskPublisher = Just((data: mockData, response: response!))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
        
        // Override URLSession for testing
        let apiClient = TestableApiClientRepository(mockSession: mockURLSession)
        let expectation = self.expectation(description: "Should return decoded data")
        var receivedResponse: MockResponse?
        
        // When
        apiClient.request(endPoint: "/test", queryItems: [])
            .sink(
                receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("Expected successful completion")
                    }
                    expectation.fulfill()
                },
                receiveValue: { (response: MockResponse) in
                    receivedResponse = response
                }
            )
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(receivedResponse)
        XCTAssertEqual(receivedResponse?.id, "123")
        XCTAssertEqual(receivedResponse?.name, "Test Item")
    }
    
    
    
    func testRequestWithDecodingErrorReturnsDecodingError() {
        // Given
        let mockURLSession = MockURLSession()
        let invalidData = "invalid json".data(using: .utf8)!
        let response = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        mockURLSession.mockDataTaskPublisher = Just((data: invalidData, response: response!))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
        
        // Override URLSession for testing
        let apiClient = TestableApiClientRepository(mockSession: mockURLSession)
        let expectation = self.expectation(description: "Should return decodingError")
        var receivedError: APIError?
        
        // When
        apiClient.request(endPoint: "/test", queryItems: [])
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        receivedError = error
                        if case .decodingError = error {
                            expectation.fulfill()
                        }
                    }
                },
                receiveValue: { (_: MockResponse) in }
            )
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 1)
        if case .decodingError = receivedError {
            // Test passes if we got a decodingError
        } else {
            XCTFail("Expected decodingError, got \(String(describing: receivedError))")
        }
    }
}

// MARK: - Helper Types for Testing

struct MockResponse: Decodable, Equatable {
    let id: String
    let name: String
}

class MockURLSession {
    var mockDataTaskPublisher: AnyPublisher<(data: Data, response: URLResponse), URLError>!
}

class TestableApiClientRepository: ApiClientRepository {
    private let mockSession: MockURLSession
    
    init(mockSession: MockURLSession) {
        self.mockSession = mockSession
        super.init()
    }
    
    override func request<T>(endPoint: String, queryItems: [URLQueryItem]) -> AnyPublisher<T, APIError> where T: Decodable {
        var components = URLComponents(string: ApiConfig.baseUrl + endPoint)
        components?.queryItems = queryItems
        guard let url = components?.url else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        var apiRequest = URLRequest(url: url)
        apiRequest.addValue(ApiConfig.apiHost, forHTTPHeaderField: "x-rapidapi-host")
        apiRequest.addValue(ApiConfig.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        
        return mockSession.mockDataTaskPublisher
            .tryMap { data, urlResponse in
                guard let response = urlResponse as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                
                if response.statusCode == 204 {
                    throw APIError.noData
                } else if response.statusCode != 200 {
                    throw APIError.invalidResponse
                }
                
                return data
            }
            .mapError { error in
                if let apiError = error as? APIError {
                    return apiError
                } else {
                    return APIError.networkError(error)
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in APIError.decodingError(error) }
            .eraseToAnyPublisher()
    }
}
