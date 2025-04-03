//
//  StockRepository.swift
//  MoneyBaseStockListingChallenge
//
//  Created by Tauqeer on 03/04/25.
//
import Combine
import Foundation

protocol StockRepository {
    func fetchStocks(region: String) -> AnyPublisher<MarketSummaryResponse, APIError>
    func getStockDetails(symbol : String,region: String) -> AnyPublisher<StockDetailResponse, APIError>
}

class MarketStockRepository : StockRepository {
    
    private let apiClient : APIClientProtocal
    
    init(apiClient: APIClientProtocal = ApiClientRepository()) {
        self.apiClient = apiClient
    }
    
    func fetchStocks(region: String = "US") -> AnyPublisher<MarketSummaryResponse, APIError> {
        return apiClient.request(endPoint: "/market/v2/get-summary", queryItems: [.init(name: "region", value: region)])
    }
    
    ///According to the documentation from the https://rapidapi.com/apidojo/ap this is already depricated
    ///So this will actually always return 204 , no data
    ///So the whereever we are using it should have to check 204 and show a fallback view
    func getStockDetails(symbol: String = "US", region: String) -> AnyPublisher<StockDetailResponse, APIError> {
        let queryItems : [URLQueryItem] = [
            .init(name: "symbol", value: symbol),
            .init(name: "region", value: region)
        ]
        return apiClient.request(endPoint: "/stock/v2/get-summary", queryItems: queryItems)
    }
}


class StaticStockRepository: StockRepository {
    func fetchStocks(region: String) -> AnyPublisher<MarketSummaryResponse, APIError> {
        let jsonString = """
        {
          "marketSummaryAndSparkResponse": {
            "result": [
              {
                "exchangeTimezoneName": "America/New_York",
                "fullExchangeName": "SNP",
                "symbol": "^GSPC",
                "gmtOffSetMilliseconds": -18000000,
                "exchangeDataDelayedBy": 0,
                "firstTradeDateMilliseconds": -1325583000000,
                "language": "en-US",
                "regularMarketTime": {
                  "raw": 1645027268,
                  "fmt": "11:01AM EST"
                },
                "exchangeTimezoneShortName": "EST",
                "quoteType": "INDEX",
                "marketState": "REGULAR",
                "market": "us_market",
                "spark": {
                  "previousClose": 4471.07,
                  "chartPreviousClose": 4471.07,
                  "symbol": "^GSPC",
                  "timestamp": [
                    1645021800,
                    1645022100,
                    1645022400,
                    1645022700,
                    1645023000,
                    1645023300,
                    1645023600,
                    1645023900,
                    1645024200,
                    1645024500,
                    1645024800,
                    1645025100,
                    1645025400,
                    1645025700,
                    1645026000,
                    1645026300,
                    1645026600,
                    1645026900,
                    1645027251
                  ],
                  "close": [
                    4455.68,
                    4452.96,
                    4449.28,
                    4449.66,
                    4436.98,
                    4437.69,
                    4439.34,
                    4440.07,
                    4439.83,
                    4435.6,
                    4439.54,
                    4442.41,
                    4442.45,
                    4442.41,
                    4443.71,
                    4440.84,
                    4443.57,
                    4439.47,
                    4439.88
                  ],
                  "dataGranularity": 300,
                  "end": 1645045200,
                  "start": 1645021800
                },
                "priceHint": 2,
                "tradeable": false,
                "sourceInterval": 15,
                "exchange": "SNP",
                "shortName": "S&P 500",
                "region": "US",
                "triggerable": false,
                "regularMarketPreviousClose": {
                  "raw": 4471.07,
                  "fmt": "4,471.07"
                }
              },
              {
                "exchangeTimezoneName": "America/New_York",
                "fullExchangeName": "DJI",
                "symbol": "^DJI",
                "gmtOffSetMilliseconds": -18000000,
                "exchangeDataDelayedBy": 0,
                "firstTradeDateMilliseconds": 694362600000,
                "language": "en-US",
                "regularMarketTime": {
                  "raw": 1645027268,
                  "fmt": "11:01AM EST"
                },
                "exchangeTimezoneShortName": "EST",
                "quoteType": "INDEX",
                "marketState": "REGULAR",
                "market": "us_market",
                "spark": {
                  "previousClose": 34988.84,
                  "chartPreviousClose": 34988.84,
                  "symbol": "^DJI",
                  "timestamp": [
                    1645021800,
                    1645022100,
                    1645022400,
                    1645022700,
                    1645023000,
                    1645023300,
                    1645023600,
                    1645023900,
                    1645024200,
                    1645024500,
                    1645024800,
                    1645025100,
                    1645025400,
                    1645025700,
                    1645026000,
                    1645026300,
                    1645026600,
                    1645026900,
                    1645027252
                  ],
                  "close": [
                    34904.81,
                    34920.92,
                    34906.95,
                    34901.44,
                    34797.27,
                    34798.15,
                    34790.77,
                    34780.57,
                    34793.6,
                    34756.94,
                    34775.64,
                    34803.12,
                    34790.42,
                    34781.04,
                    34773.95,
                    34746.42,
                    34759.66,
                    34726.7,
                    34731.31
                  ],
                  "dataGranularity": 300,
                  "end": 1645045200,
                  "start": 1645021800
                },
                "priceHint": 2,
                "tradeable": false,
                "sourceInterval": 120,
                "exchange": "DJI",
                "shortName": "Dow 30",
                "region": "US",
                "triggerable": false,
                "regularMarketPreviousClose": {
                  "raw": 34988.84,
                  "fmt": "34,988.84"
                }
              },
              {
                "exchangeTimezoneName": "America/New_York",
                "fullExchangeName": "Nasdaq GIDS",
                "symbol": "^IXIC",
                "gmtOffSetMilliseconds": -18000000,
                "exchangeDataDelayedBy": 0,
                "firstTradeDateMilliseconds": 34612200000,
                "language": "en-US",
                "regularMarketTime": {
                  "raw": 1645027267,
                  "fmt": "11:01AM EST"
                },
                "exchangeTimezoneShortName": "EST",
                "quoteType": "INDEX",
                "marketState": "REGULAR",
                "market": "us_market",
                "spark": {
                  "previousClose": 14139.757,
                  "chartPreviousClose": 14139.757,
                  "symbol": "^IXIC",
                  "timestamp": [
                    1645021800,
                    1645022100,
                    1645022400,
                    1645022700,
                    1645023000,
                    1645023300,
                    1645023600,
                    1645023900,
                    1645024200,
                    1645024500,
                    1645024800,
                    1645025100,
                    1645025400,
                    1645025700,
                    1645026000,
                    1645026300,
                    1645026600,
                    1645026900,
                    1645027249
                  ],
                  "close": [
                    14031.158,
                    13997.412,
                    13970.643,
                    13984.775,
                    13935.36,
                    13952.171,
                    13963.806,
                    13974.68,
                    13963.572,
                    13947.231,
                    13961.29,
                    13971.85,
                    13976.939,
                    13980.627,
                    14001.162,
                    13997.104,
                    14013.052,
                    13994.993,
                    13993.2
                  ],
                  "dataGranularity": 300,
                  "end": 1645045200,
                  "start": 1645021800
                },
                "priceHint": 2,
                "tradeable": false,
                "sourceInterval": 15,
                "exchange": "NIM",
                "shortName": "Nasdaq",
                "region": "US",
                "triggerable": false,
                "regularMarketPreviousClose": {
                  "raw": 14139.757,
                  "fmt": "14,139.76"
                }
              },
              {
                "exchangeTimezoneName": "America/New_York",
                "fullExchangeName": "Chicago Options",
                "symbol": "^RUT",
                "gmtOffSetMilliseconds": -18000000,
                "exchangeDataDelayedBy": 20,
                "firstTradeDateMilliseconds": 558279000000,
                "language": "en-US",
                "regularMarketTime": {
                  "raw": 1645026365,
                  "fmt": "10:46AM EST"
                },
                "exchangeTimezoneShortName": "EST",
                "quoteType": "INDEX",
                "marketState": "REGULAR",
                "market": "us_market",
                "spark": {
                  "previousClose": 2076.4617,
                  "chartPreviousClose": 2076.4617,
                  "symbol": "^RUT",
                  "timestamp": [
                    1645021800,
                    1645022100,
                    1645022400,
                    1645022700,
                    1645023000,
                    1645023300,
                    1645023600,
                    1645023900,
                    1645024200,
                    1645024500,
                    1645024800,
                    1645025100,
                    1645025400,
                    1645025700,
                    1645026000,
                    1645026350
                  ],
                  "close": [
                    2068.8005,
                    2066.5132,
                    2063.97,
                    2066.9797,
                    2061.3696,
                    2064.7212,
                    2065.9817,
                    2067.4294,
                    2065.2976,
                    2063.198,
                    2064.6074,
                    2067.6768,
                    2069.2937,
                    2071.4756,
                    2073.4646,
                    2073.741
                  ],
                  "dataGranularity": 300,
                  "end": 1645045200,
                  "start": 1645021800
                },
                "priceHint": 2,
                "tradeable": false,
                "sourceInterval": 15,
                "exchange": "WCB",
                "shortName": "Russell 2000",
                "region": "US",
                "triggerable": false,
                "regularMarketPreviousClose": {
                  "raw": 2076.4617,
                  "fmt": "2,076.46"
                }
              },
              {
                "exchangeTimezoneName": "America/New_York",
                "fullExchangeName": "NY Mercantile",
                "symbol": "CL=F",
                "gmtOffSetMilliseconds": -18000000,
                "exchangeDataDelayedBy": 30,
                "firstTradeDateMilliseconds": 967003200000,
                "language": "en-US",
                "regularMarketTime": {
                  "raw": 1645026667,
                  "fmt": "10:51AM EST"
                },
                "exchangeTimezoneShortName": "EST",
                "quoteType": "FUTURE",
                "marketState": "REGULAR",
                "market": "us24_market",
                "spark": {
                  "previousClose": 92.07,
                  "chartPreviousClose": 92.07,
                  "symbol": "CL=F",
                  "timestamp": [
                    1644987600,
                    1644987900,
                    1644988200,
                    1644988500,
                    1644989100,
                    1644989400,
                    1644989700,
                    1644990000,
                    1644990300,
                    1644990600,
                    1644990900,
                    1644991200,
                    1644991500,
                    1644991800,
                    1644992100,
                    1644992400,
                    1644992700,
                    1644993000,
                    1644993300,
                    1644993600,
                    1644993900,
                    1644994200,
                    1644994500,
                    1644994800,
                    1644995100,
                    1644995400,
                    1644995700,
                    1644996000,
                    1644996600,
                    1644996900,
                    1644997200,
                    1644997500,
                    1644997800,
                    1644998100,
                    1644998400,
                    1644998700,
                    1644999000,
                    1644999300,
                    1644999600,
                    1644999900,
                    1645000200,
                    1645000800,
                    1645001100,
                    1645001400,
                    1645001700,
                    1645002000,
                    1645002300,
                    1645002600,
                    1645002900,
                    1645003200,
                    1645003500,
                    1645003800,
                    1645004100,
                    1645004400,
                    1645004700,
                    1645005000,
                    1645005300,
                    1645005600,
                    1645005900,
                    1645006200,
                    1645006500,
                    1645006800,
                    1645007100,
                    1645007400,
                    1645008000,
                    1645008300,
                    1645008600,
                    1645008900,
                    1645009200,
                    1645009500,
                    1645009800,
                    1645010100,
                    1645010400,
                    1645010700,
                    1645011000,
                    1645011300,
                    1645011600,
                    1645011900,
                    1645012200,
                    1645012500,
                    1645012800,
                    1645013100,
                    1645013400,
                    1645013700,
                    1645014000,
                    1645014300,
                    1645014600,
                    1645014900,
                    1645015200,
                    1645015500,
                    1645015800,
                    1645016100,
                    1645016400,
                    1645016700,
                    1645017000,
                    1645017300,
                    1645017600,
                    1645017900,
                    1645018200,
                    1645018500,
                    1645018800,
                    1645019100,
                    1645019400,
                    1645019700,
                    1645020000,
                    1645020300,
                    1645020600,
                    1645020900,
                    1645021200,
                    1645021500,
                    1645021800,
                    1645022100,
                    1645022400,
                    1645022700,
                    1645023300,
                    1645023600,
                    1645023900,
                    1645024200,
                    1645024500,
                    1645024800,
                    1645025100,
                    1645025400,
                    1645026000,
                    1645026300,
                    1645026600,
                    1645026652
                  ],
                  "close": [
                    92.06,
                    92.06,
                    92.05,
                    92.07,
                    92.07,
                    92.24,
                    92.25,
                    92.34,
                    92.32,
                    92.23,
                    92.27,
                    92.16,
                    92.16,
                    92.17,
                    92.24,
                    92.17,
                    92.26,
                    92.32,
                    92.34,
                    92.35,
                    92.35,
                    92.3,
                    92.36,
                    92.59,
                    92.64,
                    92.72,
                    92.62,
                    92.61,
                    92.55,
                    92.51,
                    92.51,
                    92.66,
                    92.62,
                    92.72,
                    92.74,
                    92.78,
                    92.93,
                    93.14,
                    93.15,
                    93.23,
                    93.19,
                    93.03,
                    93.21,
                    93.09,
                    93.21,
                    93.07,
                    92.96,
                    93.14,
                    93.06,
                    92.93,
                    92.98,
                    92.94,
                    92.91,
                    92.89,
                    92.8,
                    92.8,
                    92.58,
                    92.71,
                    92.81,
                    92.74,
                    92.71,
                    92.69,
                    92.79,
                    92.78,
                    93.1,
                    93.04,
                    93.18,
                    93.2,
                    93.16,
                    93.13,
                    92.99,
                    92.86,
                    92.83,
                    92.85,
                    92.89,
                    92.94,
                    93.08,
                    93.19,
                    93.36,
                    93.33,
                    93.38,
                    93.41,
                    93.23,
                    93.11,
                    93.07,
                    93.28,
                    93.32,
                    93.28,
                    93.44,
                    93.42,
                    93.26,
                    93.21,
                    93.09,
                    93.16,
                    93.21,
                    93.15,
                    93.26,
                    93.11,
                    93.36,
                    93.4,
                    93.21,
                    93.12,
                    93.32,
                    93.53,
                    93.44,
                    93.52,
                    93.24,
                    93.48,
                    93.4,
                    93.34,
                    93.67,
                    93.54,
                    93.68,
                    93.69,
                    93.97,
                    94,
                    94.08,
                    94.17,
                    94.06,
                    94.01,
                    93.98,
                    94.1,
                    94.26,
                    94.44,
                    94.55,
                    94.52
                  ],
                  "dataGranularity": 300,
                  "end": 1645073940,
                  "start": 1644987600
                },
                "priceHint": 2,
                "tradeable": false,
                "sourceInterval": 30,
                "exchange": "NYM",
                "shortName": "Crude Oil",
                "region": "US",
                "triggerable": false,
                "regularMarketPreviousClose": {
                  "raw": 92.07,
                  "fmt": "92.07"
                }
              },
              {
                "exchangeTimezoneName": "America/New_York",
                "fullExchangeName": "COMEX",
                "symbol": "GC=F",
                "gmtOffSetMilliseconds": -18000000,
                "exchangeDataDelayedBy": 30,
                "firstTradeDateMilliseconds": 967608000000,
                "language": "en-US",
                "regularMarketTime": {
                  "raw": 1645026665,
                  "fmt": "10:51AM EST"
                },
                "exchangeTimezoneShortName": "EST",
                "quoteType": "FUTURE",
                "marketState": "REGULAR",
                "market": "us24_market",
                "spark": {
                  "previousClose": 1856.2,
                  "chartPreviousClose": 1856.2,
                  "symbol": "GC=F",
                  "timestamp": [
                    1644987600,
                    1644987900,
                    1644988200,
                    1644988500,
                    1644988800,
                    1644989100,
                    1644989400,
                    1644989700,
                    1644990000,
                    1644990300,
                    1644990600,
                    1644990900,
                    1644991200,
                    1644991500,
                    1644991800,
                    1644992100,
                    1644992400,
                    1644993000,
                    1644993300,
                    1644993600,
                    1644993900,
                    1644994200,
                    1644994500,
                    1644994800,
                    1644995100,
                    1644995400,
                    1644995700,
                    1644996000,
                    1644996300,
                    1644996600,
                    1644996900,
                    1644997200,
                    1644997500,
                    1644997800,
                    1644998100,
                    1644998400,
                    1644998700,
                    1644999000,
                    1644999300,
                    1644999600,
                    1644999900,
                    1645000200,
                    1645000800,
                    1645001100,
                    1645001400,
                    1645001700,
                    1645002000,
                    1645002300,
                    1645002900,
                    1645003200,
                    1645003500,
                    1645003800,
                    1645004100,
                    1645004400,
                    1645004700,
                    1645005000,
                    1645005300,
                    1645005600,
                    1645005900,
                    1645006200,
                    1645006500,
                    1645006800,
                    1645007100,
                    1645007400,
                    1645008000,
                    1645008300,
                    1645008600,
                    1645008900,
                    1645009200,
                    1645009500,
                    1645009800,
                    1645010100,
                    1645010400,
                    1645010700,
                    1645011000,
                    1645011300,
                    1645011600,
                    1645011900,
                    1645012500,
                    1645012800,
                    1645013100,
                    1645013400,
                    1645013700,
                    1645014000,
                    1645014300,
                    1645014600,
                    1645014900,
                    1645015200,
                    1645015500,
                    1645015800,
                    1645016100,
                    1645016400,
                    1645016700,
                    1645017000,
                    1645017300,
                    1645017600,
                    1645017900,
                    1645018200,
                    1645018500,
                    1645018800,
                    1645019100,
                    1645019400,
                    1645019700,
                    1645020000,
                    1645020300,
                    1645020600,
                    1645020900,
                    1645021200,
                    1645021500,
                    1645021800,
                    1645022100,
                    1645022400,
                    1645022700,
                    1645023000,
                    1645023300,
                    1645023600,
                    1645023900,
                    1645024200,
                    1645024500,
                    1645024800,
                    1645025100,
                    1645025400,
                    1645025700,
                    1645026000,
                    1645026300,
                    1645026600,
                    1645026648
                  ],
                  "close": [
                    1854.4,
                    1854.4,
                    1854,
                    1854.1,
                    1854.9,
                    1854.7,
                    1855.1,
                    1855.4,
                    1855.7,
                    1856.1,
                    1856.1,
                    1855.8,
                    1855.4,
                    1855.3,
                    1855,
                    1855.7,
                    1856.5,
                    1856.3,
                    1856.1,
                    1856.3,
                    1856.8,
                    1857.1,
                    1856.6,
                    1857.1,
                    1857.7,
                    1857.1,
                    1855.7,
                    1856.2,
                    1856.9,
                    1856.6,
                    1856.5,
                    1856.8,
                    1856.9,
                    1856.5,
                    1856.5,
                    1856.6,
                    1857,
                    1857.9,
                    1858.3,
                    1858.3,
                    1857.7,
                    1857.8,
                    1858.6,
                    1858.6,
                    1858.8,
                    1858.4,
                    1858.3,
                    1857.9,
                    1858.1,
                    1857.9,
                    1858.6,
                    1858.2,
                    1858.2,
                    1858.7,
                    1859.6,
                    1860,
                    1859.8,
                    1860.7,
                    1859.9,
                    1859.1,
                    1858.6,
                    1857.3,
                    1856.2,
                    1856.6,
                    1855.7,
                    1856.3,
                    1855.6,
                    1856.1,
                    1856,
                    1856.3,
                    1856.1,
                    1856.3,
                    1855.9,
                    1856.4,
                    1856.6,
                    1856.7,
                    1856.7,
                    1856.9,
                    1857.9,
                    1857.4,
                    1856.8,
                    1856.2,
                    1856,
                    1855.5,
                    1856.3,
                    1855.8,
                    1854.4,
                    1853.4,
                    1854.4,
                    1854.6,
                    1854.3,
                    1853.3,
                    1853.8,
                    1853.8,
                    1853.2,
                    1856.2,
                    1855.1,
                    1855.2,
                    1856.4,
                    1857.7,
                    1859.6,
                    1858.3,
                    1860.3,
                    1860.7,
                    1860.2,
                    1859.6,
                    1860.4,
                    1860.1,
                    1859.7,
                    1863.9,
                    1864.6,
                    1864.7,
                    1865.1,
                    1864.4,
                    1863.4,
                    1862.7,
                    1863,
                    1862.8,
                    1864.8,
                    1863.8,
                    1863.5,
                    1862.5,
                    1862.4,
                    1863.8,
                    1863.2,
                    1863.7,
                    1864.1
                  ],
                  "dataGranularity": 300,
                  "end": 1645073940,
                  "start": 1644987600
                },
                "priceHint": 2,
                "tradeable": false,
                "sourceInterval": 15,
                "exchange": "CMX",
                "shortName": "Gold",
                "region": "US",
                "triggerable": false,
                "regularMarketPreviousClose": {
                  "raw": 1856.2,
                  "fmt": "1,856.20"
                }
              },
              {
                "exchangeTimezoneName": "America/New_York",
                "fullExchangeName": "COMEX",
                "symbol": "SI=F",
                "gmtOffSetMilliseconds": -18000000,
                "exchangeDataDelayedBy": 30,
                "firstTradeDateMilliseconds": 967608000000,
                "language": "en-US",
                "regularMarketTime": {
                  "raw": 1645026665,
                  "fmt": "10:51AM EST"
                },
                "exchangeTimezoneShortName": "EST",
                "quoteType": "FUTURE",
                "marketState": "REGULAR",
                "market": "us24_market",
                "spark": {
                  "previousClose": 23.342,
                  "chartPreviousClose": 23.342,
                  "symbol": "SI=F",
                  "timestamp": [
                    1644987600,
                    1644987900,
                    1644988200,
                    1644988500,
                    1644988800,
                    1644989100,
                    1644989400,
                    1644989700,
                    1644990000,
                    1644990300,
                    1644990600,
                    1644990900,
                    1644991200,
                    1644991500,
                    1644991800,
                    1644992100,
                    1644992400,
                    1644992700,
                    1644993300,
                    1644993900,
                    1644994200,
                    1644994500,
                    1644994800,
                    1644995100,
                    1644995400,
                    1644995700,
                    1644996000,
                    1644996300,
                    1644996600,
                    1644996900,
                    1644997200,
                    1644997500,
                    1644998100,
                    1644998400,
                    1644998700,
                    1644999000,
                    1644999300,
                    1644999600,
                    1644999900,
                    1645000200,
                    1645000800,
                    1645001100,
                    1645001400,
                    1645001700,
                    1645002000,
                    1645002300,
                    1645002600,
                    1645002900,
                    1645003200,
                    1645003500,
                    1645003800,
                    1645004100,
                    1645004400,
                    1645004700,
                    1645005000,
                    1645005300,
                    1645005600,
                    1645005900,
                    1645006500,
                    1645006800,
                    1645007100,
                    1645007400,
                    1645007700,
                    1645008000,
                    1645008300,
                    1645008600,
                    1645008900,
                    1645009200,
                    1645009500,
                    1645009800,
                    1645010100,
                    1645010400,
                    1645010700,
                    1645011000,
                    1645011300,
                    1645011600,
                    1645011900,
                    1645012200,
                    1645012500,
                    1645012800,
                    1645013100,
                    1645013400,
                    1645014000,
                    1645014300,
                    1645014600,
                    1645014900,
                    1645015200,
                    1645015500,
                    1645015800,
                    1645016100,
                    1645016400,
                    1645016700,
                    1645017000,
                    1645017300,
                    1645017600,
                    1645017900,
                    1645018200,
                    1645018500,
                    1645018800,
                    1645019100,
                    1645019400,
                    1645019700,
                    1645020000,
                    1645020300,
                    1645020600,
                    1645020900,
                    1645021200,
                    1645021500,
                    1645021800,
                    1645022100,
                    1645022400,
                    1645022700,
                    1645023000,
                    1645023300,
                    1645023600,
                    1645023900,
                    1645024200,
                    1645024500,
                    1645024800,
                    1645025100,
                    1645025400,
                    1645025700,
                    1645026000,
                    1645026300,
                    1645026600,
                    1645026647
                  ],
                  "close": [
                    23.36,
                    23.365,
                    23.36,
                    23.355,
                    23.365,
                    23.365,
                    23.385,
                    23.395,
                    23.415,
                    23.41,
                    23.41,
                    23.405,
                    23.43,
                    23.4,
                    23.39,
                    23.405,
                    23.41,
                    23.415,
                    23.425,
                    23.445,
                    23.425,
                    23.41,
                    23.43,
                    23.465,
                    23.46,
                    23.435,
                    23.425,
                    23.435,
                    23.44,
                    23.455,
                    23.46,
                    23.485,
                    23.485,
                    23.455,
                    23.485,
                    23.53,
                    23.54,
                    23.545,
                    23.535,
                    23.53,
                    23.55,
                    23.565,
                    23.55,
                    23.55,
                    23.545,
                    23.51,
                    23.525,
                    23.53,
                    23.515,
                    23.54,
                    23.525,
                    23.53,
                    23.53,
                    23.55,
                    23.545,
                    23.545,
                    23.55,
                    23.56,
                    23.51,
                    23.475,
                    23.46,
                    23.465,
                    23.505,
                    23.48,
                    23.49,
                    23.485,
                    23.49,
                    23.49,
                    23.495,
                    23.49,
                    23.49,
                    23.475,
                    23.475,
                    23.49,
                    23.49,
                    23.485,
                    23.51,
                    23.515,
                    23.515,
                    23.495,
                    23.48,
                    23.47,
                    23.47,
                    23.485,
                    23.47,
                    23.44,
                    23.41,
                    23.435,
                    23.43,
                    23.42,
                    23.38,
                    23.385,
                    23.35,
                    23.335,
                    23.375,
                    23.36,
                    23.41,
                    23.42,
                    23.39,
                    23.41,
                    23.38,
                    23.425,
                    23.395,
                    23.4,
                    23.375,
                    23.4,
                    23.395,
                    23.395,
                    23.53,
                    23.545,
                    23.54,
                    23.535,
                    23.53,
                    23.495,
                    23.48,
                    23.485,
                    23.495,
                    23.52,
                    23.515,
                    23.51,
                    23.48,
                    23.49,
                    23.51,
                    23.47,
                    23.48,
                    23.485
                  ],
                  "dataGranularity": 300,
                  "end": 1645073940,
                  "start": 1644987600
                },
                "priceHint": 3,
                "tradeable": false,
                "sourceInterval": 15,
                "exchange": "CMX",
                "shortName": "Silver",
                "region": "US",
                "triggerable": false,
                "regularMarketPreviousClose": {
                  "raw": 23.342,
                  "fmt": "23.342"
                }
              },
              {
                "exchangeTimezoneName": "Europe/London",
                "fullExchangeName": "CCY",
                "symbol": "EURUSD=X",
                "gmtOffSetMilliseconds": 0,
                "exchangeDataDelayedBy": 0,
                "firstTradeDateMilliseconds": 1070236800000,
                "language": "en-US",
                "regularMarketTime": {
                  "raw": 1645027233,
                  "fmt": "4:00PM GMT"
                },
                "exchangeTimezoneShortName": "GMT",
                "quoteType": "CURRENCY",
                "marketState": "REGULAR",
                "market": "ccy_market",
                "spark": {
                  "previousClose": 1.1364,
                  "chartPreviousClose": 1.1364,
                  "symbol": "EURUSD=X",
                  "timestamp": [
                    1644969600,
                    1644969900,
                    1644970200,
                    1644970500,
                    1644970800,
                    1644971100,
                    1644971400,
                    1644971700,
                    1644972600,
                    1644972900,
                    1644973200,
                    1644973500,
                    1644973800,
                    1644974100,
                    1644974400,
                    1644974700,
                    1644975000,
                    1644975300,
                    1644975600,
                    1644976200,
                    1644976500,
                    1644976800,
                    1644977100,
                    1644977400,
                    1644977700,
                    1644978000,
                    1644978300,
                    1644978600,
                    1644979200,
                    1644979800,
                    1644980100,
                    1644980400,
                    1644980700,
                    1644981000,
                    1644981300,
                    1644981600,
                    1644982200,
                    1644982500,
                    1644982800,
                    1644983100,
                    1644983400,
                    1644983700,
                    1644984000,
                    1644984300,
                    1644984600,
                    1644984900,
                    1644985200,
                    1644985800,
                    1644986100,
                    1644986700,
                    1644987000,
                    1644987300,
                    1644987600,
                    1644987900,
                    1644988200,
                    1644988500,
                    1644988800,
                    1644989100,
                    1644989400,
                    1644990000,
                    1644990300,
                    1644990600,
                    1644990900,
                    1644991200,
                    1644991500,
                    1644991800,
                    1644992100,
                    1644992400,
                    1644992700,
                    1644993600,
                    1644993900,
                    1644994200,
                    1644994500,
                    1644994800,
                    1644995100,
                    1644995400,
                    1644995700,
                    1644996300,
                    1644996600,
                    1644996900,
                    1644997200,
                    1644997500,
                    1644997800,
                    1644998100,
                    1644998400,
                    1644998700,
                    1644999000,
                    1644999300,
                    1644999600,
                    1644999900,
                    1645000200,
                    1645000500,
                    1645000800,
                    1645001100,
                    1645001700,
                    1645002000,
                    1645002300,
                    1645002600,
                    1645002900,
                    1645003200,
                    1645003500,
                    1645003800,
                    1645004100,
                    1645004400,
                    1645004700,
                    1645005000,
                    1645005300,
                    1645005600,
                    1645005900,
                    1645006200,
                    1645006500,
                    1645006800,
                    1645007100,
                    1645007400,
                    1645007700,
                    1645008000,
                    1645008300,
                    1645008600,
                    1645008900,
                    1645009500,
                    1645009800,
                    1645010100,
                    1645010400,
                    1645010700,
                    1645011000,
                    1645011300,
                    1645012500,
                    1645012800,
                    1645013100,
                    1645013400,
                    1645013700,
                    1645014000,
                    1645014300,
                    1645014600,
                    1645014900,
                    1645015200,
                    1645015500,
                    1645015800,
                    1645016100,
                    1645016400,
                    1645016700,
                    1645017000,
                    1645017300,
                    1645017600,
                    1645017900,
                    1645018200,
                    1645018500,
                    1645018800,
                    1645019100,
                    1645019400,
                    1645019700,
                    1645020000,
                    1645020300,
                    1645020600,
                    1645020900,
                    1645021200,
                    1645021500,
                    1645021800,
                    1645022100,
                    1645022400,
                    1645022700,
                    1645023300,
                    1645023600,
                    1645023900,
                    1645024200,
                    1645024500,
                    1645024800,
                    1645025400,
                    1645025700,
                    1645026000,
                    1645026300,
                    1645026600,
                    1645026900,
                    1645027233
                  ],
                  "close": [
                    1.1366,
                    1.1365,
                    1.1361,
                    1.136,
                    1.1364,
                    1.136,
                    1.136,
                    1.1358,
                    1.1358,
                    1.136,
                    1.1356,
                    1.1358,
                    1.1357,
                    1.1358,
                    1.1358,
                    1.1357,
                    1.1353,
                    1.1356,
                    1.1358,
                    1.1356,
                    1.1358,
                    1.1356,
                    1.136,
                    1.1357,
                    1.1356,
                    1.136,
                    1.1352,
                    1.1349,
                    1.1349,
                    1.1352,
                    1.1351,
                    1.1353,
                    1.1352,
                    1.1349,
                    1.1348,
                    1.1349,
                    1.1349,
                    1.1348,
                    1.1349,
                    1.1351,
                    1.1349,
                    1.1355,
                    1.1351,
                    1.1352,
                    1.1351,
                    1.1353,
                    1.1351,
                    1.1351,
                    1.1352,
                    1.1352,
                    1.1355,
                    1.1352,
                    1.1355,
                    1.1352,
                    1.1352,
                    1.1358,
                    1.1353,
                    1.1355,
                    1.1356,
                    1.1358,
                    1.1357,
                    1.1358,
                    1.1356,
                    1.1358,
                    1.1362,
                    1.1358,
                    1.136,
                    1.1361,
                    1.1362,
                    1.1362,
                    1.1365,
                    1.1364,
                    1.1368,
                    1.1368,
                    1.137,
                    1.1374,
                    1.137,
                    1.137,
                    1.1374,
                    1.1375,
                    1.1382,
                    1.138,
                    1.1378,
                    1.1379,
                    1.1379,
                    1.1382,
                    1.1386,
                    1.1379,
                    1.139,
                    1.1384,
                    1.1391,
                    1.139,
                    1.1393,
                    1.1392,
                    1.1392,
                    1.1391,
                    1.1382,
                    1.1382,
                    1.1384,
                    1.1382,
                    1.139,
                    1.1388,
                    1.1382,
                    1.1386,
                    1.1383,
                    1.1378,
                    1.138,
                    1.138,
                    1.1386,
                    1.1383,
                    1.1384,
                    1.1378,
                    1.1378,
                    1.1386,
                    1.1383,
                    1.1384,
                    1.1386,
                    1.1395,
                    1.1384,
                    1.1379,
                    1.1379,
                    1.138,
                    1.138,
                    1.1387,
                    1.139,
                    1.1388,
                    1.1388,
                    1.1386,
                    1.1383,
                    1.1382,
                    1.1382,
                    1.1384,
                    1.1382,
                    1.1383,
                    1.1383,
                    1.1377,
                    1.1375,
                    1.1371,
                    1.137,
                    1.1368,
                    1.1371,
                    1.1374,
                    1.1375,
                    1.1369,
                    1.1368,
                    1.1369,
                    1.1368,
                    1.1371,
                    1.1365,
                    1.1366,
                    1.1368,
                    1.1364,
                    1.1365,
                    1.1361,
                    1.1364,
                    1.1358,
                    1.1361,
                    1.1365,
                    1.1375,
                    1.1373,
                    1.1369,
                    1.1369,
                    1.1368,
                    1.1369,
                    1.1366,
                    1.1369,
                    1.1373,
                    1.1373,
                    1.137,
                    1.1369,
                    1.1366,
                    1.1368,
                    1.1366,
                    1.1369
                  ],
                  "dataGranularity": 300,
                  "end": 1645055940,
                  "start": 1644969600
                },
                "priceHint": 4,
                "tradeable": false,
                "sourceInterval": 15,
                "exchange": "CCY",
                "shortName": "EUR/USD",
                "region": "US",
                "triggerable": false,
                "regularMarketPreviousClose": {
                  "raw": 0.88,
                  "fmt": "0.8800"
                }
              },
              {
                "exchangeTimezoneName": "America/New_York",
                "fullExchangeName": "ICE Futures",
                "symbol": "^TNX",
                "gmtOffSetMilliseconds": -18000000,
                "exchangeDataDelayedBy": 30,
                "firstTradeDateMilliseconds": -252356400000,
                "language": "en-US",
                "regularMarketTime": {
                  "raw": 1645026363,
                  "fmt": "10:46AM EST"
                },
                "exchangeTimezoneShortName": "EST",
                "quoteType": "INDEX",
                "marketState": "REGULAR",
                "market": "us24_market",
                "spark": {
                  "previousClose": 2.045,
                  "chartPreviousClose": 2.045,
                  "symbol": "^TNX",
                  "timestamp": [
                    1645017600,
                    1645017900,
                    1645018200,
                    1645018500,
                    1645018800,
                    1645019100,
                    1645019400,
                    1645019700,
                    1645020000,
                    1645020300,
                    1645020600,
                    1645020900,
                    1645021200,
                    1645021500,
                    1645021800,
                    1645022100,
                    1645022400,
                    1645022700,
                    1645023000,
                    1645023300,
                    1645023600,
                    1645023900,
                    1645024200,
                    1645024500,
                    1645024800,
                    1645025100,
                    1645025400,
                    1645025700,
                    1645026000,
                    1645026343
                  ],
                  "close": [
                    2.035,
                    2.04,
                    2.043,
                    2.031,
                    2.028,
                    2.015,
                    2.019,
                    2.01,
                    2.009,
                    2.01,
                    2.015,
                    2.017,
                    2.022,
                    2.017,
                    2.021,
                    2.024,
                    2.026,
                    2.033,
                    2.028,
                    2.031,
                    2.035,
                    2.029,
                    2.038,
                    2.035,
                    2.036,
                    2.04,
                    2.042,
                    2.043,
                    2.04,
                    2.038
                  ],
                  "dataGranularity": 300,
                  "end": 1645073940,
                  "start": 1644987600
                },
                "priceHint": 2,
                "tradeable": false,
                "sourceInterval": 30,
                "exchange": "NYB",
                "shortName": "10-Yr Bond",
                "region": "US",
                "triggerable": false,
                "regularMarketPreviousClose": {
                  "raw": 2.045,
                  "fmt": "2.05"
                }
              },
              {
                "exchangeTimezoneName": "Europe/London",
                "fullExchangeName": "CCY",
                "symbol": "GBPUSD=X",
                "gmtOffSetMilliseconds": 0,
                "exchangeDataDelayedBy": 0,
                "firstTradeDateMilliseconds": 1070236800000,
                "language": "en-US",
                "regularMarketTime": {
                  "raw": 1645027233,
                  "fmt": "4:00PM GMT"
                },
                "exchangeTimezoneShortName": "GMT",
                "quoteType": "CURRENCY",
                "marketState": "REGULAR",
                "market": "ccy_market",
                "spark": {
                  "previousClose": 1.3542,
                  "chartPreviousClose": 1.3542,
                  "symbol": "GBPUSD=X",
                  "timestamp": [
                    1644969600,
                    1644969900,
                    1644970200,
                    1644970500,
                    1644970800,
                    1644971100,
                    1644971400,
                    1644971700,
                    1644972000,
                    1644972300,
                    1644972600,
                    1644972900,
                    1644973200,
                    1644973500,
                    1644973800,
                    1644974100,
                    1644974400,
                    1644974700,
                    1644975000,
                    1644975300,
                    1644975600,
                    1644975900,
                    1644976200,
                    1644976500,
                    1644976800,
                    1644977100,
                    1644977400,
                    1644977700,
                    1644978000,
                    1644978300,
                    1644978600,
                    1644978900,
                    1644979200,
                    1644979500,
                    1644979800,
                    1644980100,
                    1644980400,
                    1644980700,
                    1644981000,
                    1644981300,
                    1644981600,
                    1644981900,
                    1644982200,
                    1644982800,
                    1644983100,
                    1644983400,
                    1644983700,
                    1644984000,
                    1644984300,
                    1644984600,
                    1644984900,
                    1644985200,
                    1644985500,
                    1644985800,
                    1644986100,
                    1644986400,
                    1644986700,
                    1644987000,
                    1644987300,
                    1644987600,
                    1644987900,
                    1644988200,
                    1644988500,
                    1644988800,
                    1644989100,
                    1644989400,
                    1644989700,
                    1644990000,
                    1644990300,
                    1644990600,
                    1644990900,
                    1644991200,
                    1644991500,
                    1644991800,
                    1644992100,
                    1644992400,
                    1644992700,
                    1644993000,
                    1644993300,
                    1644993600,
                    1644993900,
                    1644994200,
                    1644994500,
                    1644994800,
                    1644995100,
                    1644995400,
                    1644995700,
                    1644996000,
                    1644996300,
                    1644996600,
                    1644996900,
                    1644997200,
                    1644997500,
                    1644997800,
                    1644998100,
                    1644998400,
                    1644998700,
                    1644999000,
                    1644999300,
                    1644999600,
                    1644999900,
                    1645000200,
                    1645000500,
                    1645000800,
                    1645001100,
                    1645001400,
                    1645001700,
                    1645002000,
                    1645002300,
                    1645002600,
                    1645002900,
                    1645003200,
                    1645003500,
                    1645003800,
                    1645004100,
                    1645004400,
                    1645004700,
                    1645005000,
                    1645005300,
                    1645005600,
                    1645005900,
                    1645006200,
                    1645006500,
                    1645006800,
                    1645007100,
                    1645007400,
                    1645007700,
                    1645008300,
                    1645008600,
                    1645008900,
                    1645009200,
                    1645009500,
                    1645009800,
                    1645010100,
                    1645010400,
                    1645010700,
                    1645011000,
                    1645011300,
                    1645011600,
                    1645012200,
                    1645012500,
                    1645012800,
                    1645013100,
                    1645013400,
                    1645013700,
                    1645014000,
                    1645014300,
                    1645014600,
                    1645014900,
                    1645015200,
                    1645015500,
                    1645015800,
                    1645016100,
                    1645016400,
                    1645016700,
                    1645017000,
                    1645017300,
                    1645017600,
                    1645017900,
                    1645018200,
                    1645018500,
                    1645018800,
                    1645019100,
                    1645019400,
                    1645019700,
                    1645020000,
                    1645020300,
                    1645020600,
                    1645020900,
                    1645021200,
                    1645021500,
                    1645021800,
                    1645022100,
                    1645022400,
                    1645022700,
                    1645023000,
                    1645023300,
                    1645023600,
                    1645023900,
                    1645024200,
                    1645024500,
                    1645024800,
                    1645025100,
                    1645025400,
                    1645025700,
                    1645026000,
                    1645026300,
                    1645026600,
                    1645026900,
                    1645027233
                  ],
                  "close": [
                    1.354,
                    1.3542,
                    1.3543,
                    1.3543,
                    1.3541,
                    1.3543,
                    1.3544,
                    1.3545,
                    1.3544,
                    1.3542,
                    1.3543,
                    1.3544,
                    1.3542,
                    1.3547,
                    1.3544,
                    1.3545,
                    1.3546,
                    1.3544,
                    1.354,
                    1.3539,
                    1.3541,
                    1.3545,
                    1.3546,
                    1.3544,
                    1.3548,
                    1.3546,
                    1.3543,
                    1.3549,
                    1.3546,
                    1.3545,
                    1.3542,
                    1.3543,
                    1.3544,
                    1.3544,
                    1.3545,
                    1.3544,
                    1.3543,
                    1.3544,
                    1.3543,
                    1.3542,
                    1.3543,
                    1.3541,
                    1.3541,
                    1.3541,
                    1.3542,
                    1.3541,
                    1.3537,
                    1.354,
                    1.3542,
                    1.3542,
                    1.3541,
                    1.3543,
                    1.3542,
                    1.3542,
                    1.3543,
                    1.3543,
                    1.3543,
                    1.3543,
                    1.3545,
                    1.3546,
                    1.3546,
                    1.3546,
                    1.3544,
                    1.3548,
                    1.3548,
                    1.355,
                    1.3548,
                    1.3551,
                    1.3551,
                    1.3553,
                    1.3552,
                    1.3551,
                    1.3547,
                    1.3549,
                    1.3551,
                    1.3553,
                    1.3553,
                    1.3556,
                    1.3556,
                    1.3555,
                    1.3556,
                    1.3553,
                    1.3555,
                    1.3554,
                    1.356,
                    1.3557,
                    1.3562,
                    1.3559,
                    1.3558,
                    1.3554,
                    1.3557,
                    1.3555,
                    1.3556,
                    1.3552,
                    1.3559,
                    1.3561,
                    1.3554,
                    1.3559,
                    1.356,
                    1.356,
                    1.3555,
                    1.3555,
                    1.356,
                    1.3559,
                    1.356,
                    1.3564,
                    1.3568,
                    1.3574,
                    1.3564,
                    1.3566,
                    1.3565,
                    1.3566,
                    1.3566,
                    1.3569,
                    1.3564,
                    1.3566,
                    1.3563,
                    1.3561,
                    1.3562,
                    1.3564,
                    1.3564,
                    1.3559,
                    1.3558,
                    1.3557,
                    1.3559,
                    1.3553,
                    1.3562,
                    1.3565,
                    1.3564,
                    1.357,
                    1.3568,
                    1.3569,
                    1.3569,
                    1.3568,
                    1.357,
                    1.3566,
                    1.3575,
                    1.3568,
                    1.3566,
                    1.3567,
                    1.3558,
                    1.356,
                    1.3556,
                    1.3559,
                    1.356,
                    1.3563,
                    1.3561,
                    1.3555,
                    1.3553,
                    1.3554,
                    1.3556,
                    1.355,
                    1.3555,
                    1.3553,
                    1.3546,
                    1.3548,
                    1.3552,
                    1.355,
                    1.3549,
                    1.3551,
                    1.3553,
                    1.355,
                    1.355,
                    1.3547,
                    1.3551,
                    1.355,
                    1.3554,
                    1.3551,
                    1.3547,
                    1.3551,
                    1.356,
                    1.3569,
                    1.3571,
                    1.3579,
                    1.358,
                    1.3577,
                    1.3575,
                    1.3569,
                    1.3576,
                    1.3574,
                    1.3575,
                    1.3573,
                    1.3576,
                    1.3573,
                    1.3582,
                    1.3583,
                    1.3572,
                    1.3577,
                    1.358,
                    1.3578
                  ],
                  "dataGranularity": 300,
                  "end": 1645055940,
                  "start": 1644969600
                },
                "priceHint": 4,
                "tradeable": false,
                "sourceInterval": 15,
                "exchange": "CCY",
                "shortName": "GBP/USD",
                "region": "US",
                "triggerable": false,
                "regularMarketPreviousClose": {
                  "raw": 0.73843,
                  "fmt": "0.7384"
                }
              },
              {
                "exchangeTimezoneName": "Europe/London",
                "fullExchangeName": "CCY",
                "symbol": "JPY=X",
                "gmtOffSetMilliseconds": 0,
                "exchangeDataDelayedBy": 0,
                "firstTradeDateMilliseconds": 846633600000,
                "language": "en-US",
                "regularMarketTime": {
                  "raw": 1645027268,
                  "fmt": "4:01PM GMT"
                },
                "exchangeTimezoneShortName": "GMT",
                "quoteType": "CURRENCY",
                "marketState": "REGULAR",
                "market": "ccy_market",
                "spark": {
                  "previousClose": 115.596,
                  "chartPreviousClose": 115.596,
                  "symbol": "JPY=X",
                  "timestamp": [
                    1644969600,
                    1644969900,
                    1644970200,
                    1644970500,
                    1644970800,
                    1644971100,
                    1644971400,
                    1644971700,
                    1644972000,
                    1644972300,
                    1644972600,
                    1644972900,
                    1644973200,
                    1644973500,
                    1644973800,
                    1644974100,
                    1644974400,
                    1644974700,
                    1644975000,
                    1644975300,
                    1644975600,
                    1644976200,
                    1644976500,
                    1644976800,
                    1644977100,
                    1644977400,
                    1644977700,
                    1644978000,
                    1644978300,
                    1644978600,
                    1644978900,
                    1644979200,
                    1644979500,
                    1644979800,
                    1644980100,
                    1644980400,
                    1644980700,
                    1644981000,
                    1644981300,
                    1644981600,
                    1644981900,
                    1644982200,
                    1644982500,
                    1644982800,
                    1644983100,
                    1644983400,
                    1644983700,
                    1644984000,
                    1644984300,
                    1644984600,
                    1644984900,
                    1644985200,
                    1644985500,
                    1644985800,
                    1644986100,
                    1644986400,
                    1644986700,
                    1644987000,
                    1644987300,
                    1644987600,
                    1644987900,
                    1644988200,
                    1644988500,
                    1644988800,
                    1644989100,
                    1644989400,
                    1644989700,
                    1644990000,
                    1644990300,
                    1644990600,
                    1644990900,
                    1644991200,
                    1644991500,
                    1644991800,
                    1644992100,
                    1644992400,
                    1644992700,
                    1644993000,
                    1644993300,
                    1644993600,
                    1644993900,
                    1644994200,
                    1644994500,
                    1644994800,
                    1644995100,
                    1644995400,
                    1644995700,
                    1644996000,
                    1644996300,
                    1644996600,
                    1644996900,
                    1644997200,
                    1644997500,
                    1644997800,
                    1644998100,
                    1644998400,
                    1644998700,
                    1644999000,
                    1644999300,
                    1644999600,
                    1644999900,
                    1645000200,
                    1645000500,
                    1645000800,
                    1645001100,
                    1645001400,
                    1645001700,
                    1645002000,
                    1645002300,
                    1645002600,
                    1645002900,
                    1645003200,
                    1645003500,
                    1645003800,
                    1645004100,
                    1645004400,
                    1645004700,
                    1645005000,
                    1645005300,
                    1645005600,
                    1645005900,
                    1645006200,
                    1645006500,
                    1645006800,
                    1645007100,
                    1645007400,
                    1645007700,
                    1645008000,
                    1645008300,
                    1645008600,
                    1645008900,
                    1645009200,
                    1645009500,
                    1645009800,
                    1645010100,
                    1645010400,
                    1645010700,
                    1645011000,
                    1645011300,
                    1645011600,
                    1645011900,
                    1645012200,
                    1645012500,
                    1645012800,
                    1645013100,
                    1645013400,
                    1645013700,
                    1645014000,
                    1645014300,
                    1645014600,
                    1645014900,
                    1645015200,
                    1645015500,
                    1645015800,
                    1645016100,
                    1645016400,
                    1645016700,
                    1645017000,
                    1645017300,
                    1645017600,
                    1645017900,
                    1645018200,
                    1645018500,
                    1645018800,
                    1645019100,
                    1645019400,
                    1645019700,
                    1645020000,
                    1645020300,
                    1645020600,
                    1645020900,
                    1645021200,
                    1645021500,
                    1645021800,
                    1645022100,
                    1645022400,
                    1645022700,
                    1645023000,
                    1645023300,
                    1645023600,
                    1645023900,
                    1645024200,
                    1645024500,
                    1645024800,
                    1645025100,
                    1645025400,
                    1645025700,
                    1645026000,
                    1645026300,
                    1645026600,
                    1645026900,
                    1645027253
                  ],
                  "close": [
                    115.668,
                    115.678,
                    115.68,
                    115.673,
                    115.67,
                    115.651,
                    115.659,
                    115.677,
                    115.66,
                    115.66,
                    115.697,
                    115.684,
                    115.73,
                    115.71,
                    115.69,
                    115.673,
                    115.674,
                    115.687,
                    115.66,
                    115.678,
                    115.65,
                    115.65,
                    115.67,
                    115.67,
                    115.69,
                    115.69,
                    115.698,
                    115.691,
                    115.701,
                    115.686,
                    115.687,
                    115.67,
                    115.668,
                    115.665,
                    115.691,
                    115.678,
                    115.697,
                    115.72,
                    115.715,
                    115.699,
                    115.69,
                    115.68,
                    115.678,
                    115.68,
                    115.696,
                    115.69,
                    115.692,
                    115.69,
                    115.68,
                    115.691,
                    115.677,
                    115.68,
                    115.675,
                    115.669,
                    115.67,
                    115.673,
                    115.665,
                    115.664,
                    115.68,
                    115.676,
                    115.677,
                    115.684,
                    115.673,
                    115.666,
                    115.66,
                    115.67,
                    115.66,
                    115.663,
                    115.658,
                    115.672,
                    115.694,
                    115.691,
                    115.67,
                    115.68,
                    115.66,
                    115.648,
                    115.645,
                    115.65,
                    115.64,
                    115.659,
                    115.644,
                    115.644,
                    115.639,
                    115.658,
                    115.654,
                    115.677,
                    115.68,
                    115.691,
                    115.663,
                    115.678,
                    115.672,
                    115.657,
                    115.645,
                    115.63,
                    115.639,
                    115.623,
                    115.636,
                    115.65,
                    115.69,
                    115.688,
                    115.747,
                    115.73,
                    115.77,
                    115.747,
                    115.758,
                    115.73,
                    115.723,
                    115.73,
                    115.708,
                    115.685,
                    115.697,
                    115.69,
                    115.669,
                    115.669,
                    115.681,
                    115.676,
                    115.666,
                    115.66,
                    115.657,
                    115.66,
                    115.67,
                    115.665,
                    115.68,
                    115.69,
                    115.694,
                    115.692,
                    115.689,
                    115.712,
                    115.704,
                    115.717,
                    115.693,
                    115.704,
                    115.689,
                    115.695,
                    115.686,
                    115.68,
                    115.672,
                    115.66,
                    115.671,
                    115.67,
                    115.683,
                    115.66,
                    115.673,
                    115.681,
                    115.686,
                    115.695,
                    115.689,
                    115.704,
                    115.72,
                    115.709,
                    115.678,
                    115.68,
                    115.668,
                    115.683,
                    115.688,
                    115.704,
                    115.695,
                    115.688,
                    115.679,
                    115.681,
                    115.696,
                    115.732,
                    115.705,
                    115.662,
                    115.56,
                    115.552,
                    115.483,
                    115.455,
                    115.45,
                    115.469,
                    115.48,
                    115.53,
                    115.488,
                    115.466,
                    115.412,
                    115.415,
                    115.416,
                    115.411,
                    115.439,
                    115.46,
                    115.435,
                    115.447,
                    115.471,
                    115.492,
                    115.485,
                    115.508,
                    115.488,
                    115.494,
                    115.51,
                    115.47,
                    115.431,
                    115.434
                  ],
                  "dataGranularity": 300,
                  "end": 1645055940,
                  "start": 1644969600
                },
                "priceHint": 4,
                "tradeable": false,
                "sourceInterval": 15,
                "exchange": "CCY",
                "shortName": "USD/JPY",
                "region": "US",
                "triggerable": false,
                "regularMarketPreviousClose": {
                  "raw": 115.596,
                  "fmt": "115.5960"
                }
              },
              {
                "exchangeTimezoneName": "UTC",
                "fullExchangeName": "CCC",
                "symbol": "BTC-USD",
                "gmtOffSetMilliseconds": 0,
                "exchangeDataDelayedBy": 0,
                "firstTradeDateMilliseconds": 1410912000000,
                "language": "en-US",
                "regularMarketTime": {
                  "raw": 1645027140,
                  "fmt": "3:59PM UTC"
                },
                "exchangeTimezoneShortName": "UTC",
                "quoteType": "CRYPTOCURRENCY",
                "marketState": "REGULAR",
                "market": "ccc_market",
                "spark": {
                  "previousClose": 44503.094,
                  "chartPreviousClose": 44503.094,
                  "symbol": "BTC-USD",
                  "timestamp": [
                    1644969600,
                    1644969900,
                    1644970200,
                    1644970500,
                    1644970800,
                    1644971100,
                    1644971400,
                    1644971700,
                    1644972000,
                    1644972300,
                    1644972600,
                    1644972900,
                    1644973200,
                    1644973500,
                    1644973800,
                    1644974100,
                    1644974400,
                    1644974700,
                    1644975000,
                    1644975300,
                    1644975600,
                    1644975900,
                    1644976200,
                    1644976500,
                    1644976800,
                    1644977100,
                    1644977400,
                    1644977700,
                    1644978000,
                    1644978300,
                    1644978600,
                    1644978900,
                    1644979200,
                    1644979500,
                    1644979800,
                    1644980100,
                    1644980400,
                    1644980700,
                    1644981000,
                    1644981300,
                    1644981600,
                    1644981900,
                    1644982200,
                    1644982500,
                    1644982800,
                    1644983100,
                    1644983400,
                    1644983700,
                    1644984000,
                    1644984300,
                    1644984600,
                    1644984900,
                    1644985200,
                    1644985500,
                    1644985800,
                    1644986100,
                    1644986400,
                    1644986700,
                    1644987000,
                    1644987300,
                    1644987600,
                    1644987900,
                    1644988200,
                    1644988500,
                    1644988800,
                    1644989100,
                    1644989400,
                    1644989700,
                    1644990000,
                    1644990300,
                    1644990600,
                    1644990900,
                    1644991200,
                    1644991500,
                    1644991800,
                    1644992100,
                    1644992400,
                    1644992700,
                    1644993000,
                    1644993300,
                    1644993600,
                    1644993900,
                    1644994200,
                    1644994500,
                    1644994800,
                    1644995100,
                    1644995400,
                    1644995700,
                    1644996000,
                    1644996300,
                    1644996600,
                    1644996900,
                    1644997200,
                    1644997500,
                    1644997800,
                    1644998100,
                    1644998400,
                    1644998700,
                    1644999000,
                    1644999300,
                    1644999600,
                    1644999900,
                    1645000200,
                    1645000500,
                    1645000800,
                    1645001100,
                    1645001400,
                    1645001700,
                    1645002000,
                    1645002300,
                    1645002600,
                    1645002900,
                    1645003200,
                    1645003500,
                    1645003800,
                    1645004100,
                    1645004400,
                    1645004700,
                    1645005000,
                    1645005300,
                    1645005600,
                    1645005900,
                    1645006200,
                    1645006500,
                    1645006800,
                    1645007100,
                    1645007400,
                    1645007700,
                    1645008000,
                    1645008300,
                    1645008600,
                    1645008900,
                    1645009200,
                    1645009500,
                    1645009800,
                    1645010100,
                    1645010400,
                    1645010700,
                    1645011000,
                    1645011300,
                    1645011600,
                    1645011900,
                    1645012200,
                    1645012500,
                    1645012800,
                    1645013100,
                    1645013400,
                    1645013700,
                    1645014000,
                    1645014300,
                    1645014600,
                    1645014900,
                    1645015200,
                    1645015500,
                    1645015800,
                    1645016100,
                    1645016400,
                    1645016700,
                    1645017000,
                    1645017300,
                    1645017600,
                    1645017900,
                    1645018200,
                    1645018500,
                    1645018800,
                    1645019100,
                    1645019400,
                    1645019700,
                    1645020000,
                    1645020300,
                    1645020600,
                    1645020900,
                    1645021200,
                    1645021500,
                    1645021800,
                    1645022100,
                    1645022400,
                    1645022700,
                    1645023000,
                    1645023300,
                    1645023600,
                    1645023900,
                    1645024200,
                    1645024500,
                    1645024800,
                    1645025100,
                    1645025400,
                    1645025700,
                    1645026000,
                    1645026300,
                    1645026600,
                    1645026900,
                    1645027140
                  ],
                  "close": [
                    44503.094,
                    44453.273,
                    44445.098,
                    44374.75,
                    44298.13,
                    44286.598,
                    44265.363,
                    44275.68,
                    44245.957,
                    44222.023,
                    44213.875,
                    44229.06,
                    44224.12,
                    44212.195,
                    44157.926,
                    44123.02,
                    44098.465,
                    44152.453,
                    44138.38,
                    44108.14,
                    44022.43,
                    44043.445,
                    44017.87,
                    44004.836,
                    44045.55,
                    44040.184,
                    44042.66,
                    44010.82,
                    44018.266,
                    44009.016,
                    43971.75,
                    43971.695,
                    43994.176,
                    44014.78,
                    44007.52,
                    44049.695,
                    44085.18,
                    44109.812,
                    44141.023,
                    44129.133,
                    44120.566,
                    44118.906,
                    44062.277,
                    44016.89,
                    44037.426,
                    44037.023,
                    44040.535,
                    44014.69,
                    44011.207,
                    44005.152,
                    43955.48,
                    43860.504,
                    43801.043,
                    43762.27,
                    43798.242,
                    43824.164,
                    43863.062,
                    43854.95,
                    43871.184,
                    43901.3,
                    43911.066,
                    43963.18,
                    44004.824,
                    44027.45,
                    44035.316,
                    44036.504,
                    44064.66,
                    44044.844,
                    44021.895,
                    44047.414,
                    44079.414,
                    44063.05,
                    44078.55,
                    44079.184,
                    44100.76,
                    44122.95,
                    44153.402,
                    44145.918,
                    44122.11,
                    44133.125,
                    44111.32,
                    44106.04,
                    44111.984,
                    44062.38,
                    44073.363,
                    44066.645,
                    44031.6,
                    44000.586,
                    44023.254,
                    44010.188,
                    44005.164,
                    44023.984,
                    44065.055,
                    44084.508,
                    44102.93,
                    44141.863,
                    44164.656,
                    44195.918,
                    44211.34,
                    44279.207,
                    44308.312,
                    44289.875,
                    44260.207,
                    44251.863,
                    44199.25,
                    44189.508,
                    44187.03,
                    44160.492,
                    44168.082,
                    44217.715,
                    44135.42,
                    44148.254,
                    44148.477,
                    44152.566,
                    44199.324,
                    44216.117,
                    44173.36,
                    44124.168,
                    44112.02,
                    44076.367,
                    44066.074,
                    44072.26,
                    44085.184,
                    44080.87,
                    44034.758,
                    43954.9,
                    43962.133,
                    43976.113,
                    44034.105,
                    44065.68,
                    44089.57,
                    44120.297,
                    44126.36,
                    44211.96,
                    44190.7,
                    44183.867,
                    44188.57,
                    44159.035,
                    44161.715,
                    44173.477,
                    44212.547,
                    44191.246,
                    44182.938,
                    44206.45,
                    44176.742,
                    44201.58,
                    44112.477,
                    44092.215,
                    44109.387,
                    44127.766,
                    44147.56,
                    44113.336,
                    44083.098,
                    44050.42,
                    44074.98,
                    44022.637,
                    44051.977,
                    43995.375,
                    44062.156,
                    44034.3,
                    44033.86,
                    44004.91,
                    44064.57,
                    43924.81,
                    43897.566,
                    43857.92,
                    43671.293,
                    43644.656,
                    43671.81,
                    43689.473,
                    43673.727,
                    43715.844,
                    43647.703,
                    43636.84,
                    43675.074,
                    43665.75,
                    43655.1,
                    43638.395,
                    43523.97,
                    43480.14,
                    43599.145,
                    43624.613,
                    43614.703,
                    43590.406,
                    43585.21,
                    43619.84,
                    43638.254,
                    43653.375,
                    43669.8,
                    43663.707,
                    43629.16,
                    43600.17,
                    43599.984
                  ],
                  "dataGranularity": 300,
                  "end": 1645055940,
                  "start": 1644969600
                },
                "priceHint": 2,
                "tradeable": false,
                "sourceInterval": 15,
                "exchange": "CCC",
                "region": "US",
                "triggerable": false,
                "regularMarketPreviousClose": {
                  "raw": 44503.094,
                  "fmt": "44,503.09"
                }
              },
              {
                "exchangeTimezoneName": "America/New_York",
                "fullExchangeName": "Nasdaq GIDS",
                "symbol": "^CMC200",
                "gmtOffSetMilliseconds": -18000000,
                "exchangeDataDelayedBy": 0,
                "firstTradeDateMilliseconds": 1546266600000,
                "language": "en-US",
                "regularMarketTime": {
                  "raw": 1645027187,
                  "fmt": "10:59AM EST"
                },
                "exchangeTimezoneShortName": "EST",
                "quoteType": "INDEX",
                "marketState": "REGULAR",
                "market": "us_market",
                "spark": {
                  "previousClose": 1014.3838,
                  "chartPreviousClose": 1014.3838,
                  "symbol": "^CMC200",
                  "timestamp": [
                    1645021800,
                    1645022100,
                    1645022400,
                    1645022700,
                    1645023000,
                    1645023300,
                    1645023600,
                    1645023900,
                    1645024200,
                    1645024500,
                    1645024800,
                    1645025100,
                    1645025400,
                    1645025700,
                    1645026000,
                    1645026300,
                    1645026600,
                    1645026900,
                    1645027187
                  ],
                  "close": [
                    1002.5072,
                    1003.0764,
                    1002.7462,
                    1002.1074,
                    999.9981,
                    999.0472,
                    1000.6049,
                    1002.3179,
                    1001.8271,
                    1001.6021,
                    1000.8424,
                    1002.2333,
                    1002.6042,
                    1002.3722,
                    1003.0596,
                    1003.3753,
                    1002.7649,
                    1002.1252,
                    1001.7338
                  ],
                  "dataGranularity": 300,
                  "end": 1645045200,
                  "start": 1645021800
                },
                "priceHint": 2,
                "tradeable": false,
                "sourceInterval": 15,
                "exchange": "NIM",
                "shortName": "CMC Crypto 200",
                "region": "US",
                "triggerable": false,
                "regularMarketPreviousClose": {
                  "raw": 1014.3838,
                  "fmt": "1,014.38"
                }
              },
              {
                "exchangeTimezoneName": "Europe/London",
                "fullExchangeName": "FTSE Index",
                "symbol": "^FTSE",
                "gmtOffSetMilliseconds": 0,
                "exchangeDataDelayedBy": 15,
                "firstTradeDateMilliseconds": 441964800000,
                "language": "en-US",
                "regularMarketTime": {
                  "raw": 1645026368,
                  "fmt": "3:46PM GMT"
                },
                "exchangeTimezoneShortName": "GMT",
                "quoteType": "INDEX",
                "marketState": "REGULAR",
                "market": "gb_market",
                "spark": {
                  "previousClose": 7608.92,
                  "chartPreviousClose": 7608.92,
                  "symbol": "^FTSE",
                  "timestamp": [
                    1644998400,
                    1644998700,
                    1644999000,
                    1644999300,
                    1644999600,
                    1644999900,
                    1645000200,
                    1645000500,
                    1645000800,
                    1645001100,
                    1645001400,
                    1645001700,
                    1645002000,
                    1645002300,
                    1645002600,
                    1645002900,
                    1645003200,
                    1645003500,
                    1645003800,
                    1645004100,
                    1645004400,
                    1645004700,
                    1645005000,
                    1645005300,
                    1645005600,
                    1645005900,
                    1645006200,
                    1645006500,
                    1645006800,
                    1645007100,
                    1645007400,
                    1645007700,
                    1645008000,
                    1645008300,
                    1645008600,
                    1645008900,
                    1645009200,
                    1645009500,
                    1645009800,
                    1645010100,
                    1645010400,
                    1645010700,
                    1645011000,
                    1645011300,
                    1645011600,
                    1645011900,
                    1645012200,
                    1645012500,
                    1645012800,
                    1645013100,
                    1645013400,
                    1645013700,
                    1645014000,
                    1645014300,
                    1645014600,
                    1645014900,
                    1645015200,
                    1645015500,
                    1645015800,
                    1645016100,
                    1645016400,
                    1645016700,
                    1645017000,
                    1645017300,
                    1645017600,
                    1645017900,
                    1645018200,
                    1645018500,
                    1645018800,
                    1645019100,
                    1645019400,
                    1645019700,
                    1645020000,
                    1645020300,
                    1645020600,
                    1645020900,
                    1645021200,
                    1645021500,
                    1645021800,
                    1645022100,
                    1645022400,
                    1645022700,
                    1645023000,
                    1645023300,
                    1645023600,
                    1645023900,
                    1645024200,
                    1645024500,
                    1645024800,
                    1645025100,
                    1645025400,
                    1645025700,
                    1645026000,
                    1645026350
                  ],
                  "close": [
                    7602.1,
                    7598.87,
                    7612.24,
                    7626.44,
                    7624.29,
                    7620.4,
                    7618.16,
                    7622.08,
                    7612.5,
                    7616.76,
                    7615.32,
                    7618.33,
                    7619.04,
                    7597.07,
                    7607.36,
                    7608.14,
                    7610.74,
                    7610.26,
                    7612,
                    7605.77,
                    7607.2,
                    7601.56,
                    7602.33,
                    7595.53,
                    7593.05,
                    7595.87,
                    7597.51,
                    7585.62,
                    7579.24,
                    7581.56,
                    7585.7,
                    7581.92,
                    7590.71,
                    7594.03,
                    7592.01,
                    7590.05,
                    7592.62,
                    7594.09,
                    7589.44,
                    7590.24,
                    7587.66,
                    7589.23,
                    7588.73,
                    7593.92,
                    7593.23,
                    7593.3,
                    7589.36,
                    7588.73,
                    7592.38,
                    7590.15,
                    7588.35,
                    7586.17,
                    7585.71,
                    7587.76,
                    7587.78,
                    7581.08,
                    7580.78,
                    7582.99,
                    7583.1,
                    7581.79,
                    7581.05,
                    7579.24,
                    7581.62,
                    7588.75,
                    7587.97,
                    7587.36,
                    7592.63,
                    7588.52,
                    7586.86,
                    7577.43,
                    7579.04,
                    7576,
                    7574,
                    7571.52,
                    7566.89,
                    7565.32,
                    7564.44,
                    7568.7,
                    7582.35,
                    7588.68,
                    7586.8,
                    7583.44,
                    7577.62,
                    7584.05,
                    7583.84,
                    7582.91,
                    7585.07,
                    7583.22,
                    7582.41,
                    7590.94,
                    7595.73,
                    7593.11,
                    7590.56,
                    7589.03
                  ],
                  "dataGranularity": 300,
                  "end": 1645029000,
                  "start": 1644998400
                },
                "priceHint": 2,
                "tradeable": false,
                "sourceInterval": 15,
                "exchange": "FGI",
                "shortName": "FTSE 100",
                "region": "US",
                "triggerable": false,
                "regularMarketPreviousClose": {
                  "raw": 7608.92,
                  "fmt": "7,608.92"
                }
              },
              {
                "exchangeTimezoneName": "Asia/Tokyo",
                "fullExchangeName": "Osaka",
                "symbol": "^N225",
                "gmtOffSetMilliseconds": 32400000,
                "exchangeDataDelayedBy": 0,
                "firstTradeDateMilliseconds": -157420800000,
                "language": "en-US",
                "regularMarketTime": {
                  "raw": 1644992102,
                  "fmt": "3:15PM JST"
                },
                "exchangeTimezoneShortName": "JST",
                "quoteType": "INDEX",
                "marketState": "PREPRE",
                "market": "jp_market",
                "spark": {
                  "previousClose": 26865.19,
                  "chartPreviousClose": 26865.19,
                  "symbol": "^N225",
                  "timestamp": [
                    1644969600,
                    1644969900,
                    1644970200,
                    1644970500,
                    1644970800,
                    1644971100,
                    1644971400,
                    1644971700,
                    1644972000,
                    1644972300,
                    1644972600,
                    1644972900,
                    1644973200,
                    1644973500,
                    1644973800,
                    1644974100,
                    1644974400,
                    1644974700,
                    1644975000,
                    1644975300,
                    1644975600,
                    1644975900,
                    1644976200,
                    1644976500,
                    1644976800,
                    1644977100,
                    1644977400,
                    1644977700,
                    1644978000,
                    1644978300,
                    1644978600,
                    1644978900,
                    1644982200,
                    1644982500,
                    1644982800,
                    1644983100,
                    1644983400,
                    1644983700,
                    1644984000,
                    1644984300,
                    1644984600,
                    1644984900,
                    1644985200,
                    1644985500,
                    1644985800,
                    1644986100,
                    1644986400,
                    1644986700,
                    1644987000,
                    1644987300,
                    1644987600,
                    1644987900,
                    1644988200,
                    1644988500,
                    1644988800,
                    1644989100,
                    1644989400,
                    1644989700,
                    1644990000,
                    1644990300,
                    1644990600,
                    1644990900
                  ],
                  "close": [
                    27373.78,
                    27391.56,
                    27405.98,
                    27446.3,
                    27396.39,
                    27377.21,
                    27387.2,
                    27398.22,
                    27367.76,
                    27371.02,
                    27363.88,
                    27356.38,
                    27365.86,
                    27400.6,
                    27380.84,
                    27385.18,
                    27376.57,
                    27391.71,
                    27390.35,
                    27392.47,
                    27385.79,
                    27375.96,
                    27381.94,
                    27383.77,
                    27410.26,
                    27429.44,
                    27419.87,
                    27423.38,
                    27421.21,
                    27422.51,
                    27428.02,
                    27428.02,
                    27428.9,
                    27432.82,
                    27423.16,
                    27419.18,
                    27422.38,
                    27427.91,
                    27426.57,
                    27422.01,
                    27419.62,
                    27411.55,
                    27405.83,
                    27392.25,
                    27403.55,
                    27404.69,
                    27413.34,
                    27411.25,
                    27429.21,
                    27434.08,
                    27448.94,
                    27452.78,
                    27472.65,
                    27458.77,
                    27460.38,
                    27444.76,
                    27453.97,
                    27454.52,
                    27455.23,
                    27466.05,
                    27466.25,
                    27486.09
                  ],
                  "dataGranularity": 300,
                  "end": 1644991200,
                  "start": 1644969600
                },
                "priceHint": 2,
                "tradeable": false,
                "sourceInterval": 20,
                "exchange": "OSA",
                "shortName": "Nikkei 225",
                "region": "US",
                "triggerable": false,
                "regularMarketPreviousClose": {
                  "raw": 26865.19,
                  "fmt": "26,865.19"
                }
              }
            ],
            "error": null
          }
        }
        """
        
        guard let data = jsonString.data(using: .utf8) else {
            return Fail(error: APIError.decodingError(NSError())).eraseToAnyPublisher()
        }
        
        return Just(data)
            .decode(type: MarketSummaryResponse.self, decoder: JSONDecoder())
            .mapError { APIError.decodingError($0) }
            .eraseToAnyPublisher()
    }
    
    func getStockDetails(symbol: String, region: String) -> AnyPublisher<StockDetailResponse, APIError> {
        let jsonString = """
        {
          "defaultKeyStatistics": {
            "annualHoldingsTurnover": {},
            "enterpriseToRevenue": {
              "raw": 1.564,
              "fmt": "1.56"
            },
            "beta3Year": {},
            "profitMargins": {
              "raw": -0.00337,
              "fmt": "-0.34%"
            },
            "enterpriseToEbitda": {
              "raw": 51.987,
              "fmt": "51.99"
            },
            "52WeekChange": {
              "raw": -0.54102564,
              "fmt": "-54.10%"
            },
            "morningStarRiskRating": {},
            "forwardEps": {
              "raw": -0.02,
              "fmt": "-0.02"
            },
            "revenueQuarterlyGrowth": {},
            "sharesOutstanding": {
              "raw": 395825984,
              "fmt": "395.83M",
              "longFmt": "395,825,984"
            },
            "fundInceptionDate": {},
            "annualReportExpenseRatio": {},
            "totalAssets": {},
            "bookValue": {
              "raw": 1.624,
              "fmt": "1.62"
            },
            "sharesShort": {
              "raw": 15221854,
              "fmt": "15.22M",
              "longFmt": "15,221,854"
            },
            "sharesPercentSharesOut": {
              "raw": 0.0385,
              "fmt": "3.85%"
            },
            "fundFamily": null,
            "lastFiscalYearEnd": {
              "raw": 1609372800,
              "fmt": "2020-12-31"
            },
            "heldPercentInstitutions": {
              "raw": 0.37293997,
              "fmt": "37.29%"
            },
            "netIncomeToCommon": {
              "raw": -2043000,
              "fmt": "-2.04M",
              "longFmt": "-2,043,000"
            },
            "trailingEps": {
              "raw": -0.011,
              "fmt": "-0.0110"
            },
            "lastDividendValue": {},
            "SandP52WeekChange": {
              "raw": 0.13729191,
              "fmt": "13.73%"
            },
            "priceToBook": {
              "raw": 2.1548645,
              "fmt": "2.15"
            },
            "heldPercentInsiders": {
              "raw": 0.0127799995,
              "fmt": "1.28%"
            },
            "nextFiscalYearEnd": {
              "raw": 1672444800,
              "fmt": "2022-12-31"
            },
            "yield": {},
            "mostRecentQuarter": {
              "raw": 1632960000,
              "fmt": "2021-09-30"
            },
            "shortRatio": {
              "raw": 2.79,
              "fmt": "2.79"
            },
            "sharesShortPreviousMonthDate": {
              "raw": 1640908800,
              "fmt": "2021-12-31"
            },
            "floatShares": {
              "raw": 343607795,
              "fmt": "343.61M",
              "longFmt": "343,607,795"
            },
            "beta": {
              "raw": 2.062655,
              "fmt": "2.06"
            },
            "enterpriseValue": {
              "raw": 947669056,
              "fmt": "947.67M",
              "longFmt": "947,669,056"
            },
            "priceHint": {
              "raw": 4,
              "fmt": "4",
              "longFmt": "4"
            },
            "threeYearAverageReturn": {},
            "lastSplitDate": {
              "raw": 1200614400,
              "fmt": "2008-01-18"
            },
            "lastSplitFactor": "1:10",
            "legalType": null,
            "lastDividendDate": {},
            "morningStarOverallRating": {},
            "earningsQuarterlyGrowth": {},
            "priceToSalesTrailing12Months": {},
            "dateShortInterest": {
              "raw": 1643587200,
              "fmt": "2022-01-31"
            },
            "pegRatio": {
              "raw": -3.07,
              "fmt": "-3.07"
            },
            "ytdReturn": {},
            "forwardPE": {
              "raw": -174.975,
              "fmt": "-174.98"
            },
            "maxAge": 1,
            "lastCapGain": {},
            "shortPercentOfFloat": {},
            "sharesShortPriorMonth": {
              "raw": 14293703,
              "fmt": "14.29M",
              "longFmt": "14,293,703"
            },
            "impliedSharesOutstanding": {
              "raw": 0,
              "fmt": null,
              "longFmt": "0"
            },
            "category": null,
            "fiveYearAverageReturn": {}
          },
          "details": {},
          "summaryProfile": {
            "zip": "2",
            "sector": "Healthcare",
            "fullTimeEmployees": 1000,
            "longBusinessSummary": "Amarin Corporation plc, a pharmaceutical company, engages in the development and commercialization of therapeutics for the treatment of cardiovascular diseases in the United States. Its lead product is VASCEPA, a prescription-only omega-3 fatty acid product, used as an adjunct to diet for reducing triglyceride levels in adult patients with severe hypertriglyceridemia. The company sells its products principally to wholesalers and specialty pharmacy providers. It has a collaboration with Mochida Pharmaceutical Co., Ltd. to develop and commercialize drug products and indications based on the active pharmaceutical ingredient in Vascepa, the omega-3 acid, and eicosapentaenoic acid. The company was formerly known as Ethical Holdings plc and changed its name to Amarin Corporation plc in 1999. Amarin Corporation plc was incorporated in 1989 and is headquartered in Dublin, Ireland.",
            "city": "Dublin",
            "phone": "353 1 669 9020",
            "country": "Ireland",
            "companyOfficers": [],
            "website": "https://www.amarincorp.com",
            "maxAge": 86400,
            "address1": "Grand Canal Docklands",
            "industry": "Biotechnology",
            "address2": "Block C 77 Sir John Rogerson's Quay"
          },
          "recommendationTrend": {
            "trend": [
              {
                "period": "0m",
                "strongBuy": 2,
                "buy": 3,
                "hold": 0,
                "sell": 0,
                "strongSell": 0
              },
              {
                "period": "-1m",
                "strongBuy": 1,
                "buy": 5,
                "hold": 2,
                "sell": 1,
                "strongSell": 0
              },
              {
                "period": "-2m",
                "strongBuy": 1,
                "buy": 5,
                "hold": 2,
                "sell": 1,
                "strongSell": 0
              },
              {
                "period": "-3m",
                "strongBuy": 2,
                "buy": 3,
                "hold": 0,
                "sell": 0,
                "strongSell": 0
              }
            ],
            "maxAge": 86400
          },
          "financialsTemplate": {
            "code": "N",
            "maxAge": 1
          },
          "majorDirectHolders": {
            "holders": [],
            "maxAge": 1
          },
          "earnings": {
            "maxAge": 86400,
            "earningsChart": {
              "quarterly": [
                {
                  "date": "4Q2020",
                  "actual": {
                    "raw": 0.01,
                    "fmt": "0.01"
                  },
                  "estimate": {
                    "raw": -0.01,
                    "fmt": "-0.01"
                  }
                },
                {
                  "date": "1Q2021",
                  "actual": {
                    "raw": 0,
                    "fmt": "0.00"
                  },
                  "estimate": {
                    "raw": -0.05,
                    "fmt": "-0.05"
                  }
                },
                {
                  "date": "2Q2021",
                  "actual": {
                    "raw": 0.02,
                    "fmt": "0.02"
                  },
                  "estimate": {
                    "raw": -0.03,
                    "fmt": "-0.03"
                  }
                },
                {
                  "date": "3Q2021",
                  "actual": {
                    "raw": -0.03,
                    "fmt": "-0.03"
                  },
                  "estimate": {
                    "raw": -0.04,
                    "fmt": "-0.04"
                  }
                }
              ],
              "currentQuarterEstimate": {
                "raw": -0.02,
                "fmt": "-0.02"
              },
              "currentQuarterEstimateDate": "4Q",
              "currentQuarterEstimateYear": 2021,
              "earningsDate": [
                {
                  "raw": 1646132340,
                  "fmt": "2022-03-01"
                }
              ]
            },
            "financialsChart": {
              "yearly": [
                {
                  "date": 2017,
                  "revenue": {
                    "raw": 181104000,
                    "fmt": "181.1M",
                    "longFmt": "181,104,000"
                  },
                  "earnings": {
                    "raw": -67865000,
                    "fmt": "-67.86M",
                    "longFmt": "-67,865,000"
                  }
                },
                {
                  "date": 2018,
                  "revenue": {
                    "raw": 229214000,
                    "fmt": "229.21M",
                    "longFmt": "229,214,000"
                  },
                  "earnings": {
                    "raw": -116445000,
                    "fmt": "-116.44M",
                    "longFmt": "-116,445,000"
                  }
                },
                {
                  "date": 2019,
                  "revenue": {
                    "raw": 429755000,
                    "fmt": "429.75M",
                    "longFmt": "429,755,000"
                  },
                  "earnings": {
                    "raw": -22645000,
                    "fmt": "-22.64M",
                    "longFmt": "-22,645,000"
                  }
                },
                {
                  "date": 2020,
                  "revenue": {
                    "raw": 614060000,
                    "fmt": "614.06M",
                    "longFmt": "614,060,000"
                  },
                  "earnings": {
                    "raw": -18000000,
                    "fmt": "-18M",
                    "longFmt": "-18,000,000"
                  }
                }
              ],
              "quarterly": [
                {
                  "date": "4Q2020",
                  "revenue": {
                    "raw": 167251000,
                    "fmt": "167.25M",
                    "longFmt": "167,251,000"
                  },
                  "earnings": {
                    "raw": 4926000,
                    "fmt": "4.93M",
                    "longFmt": "4,926,000"
                  }
                },
                {
                  "date": "1Q2021",
                  "revenue": {
                    "raw": 142170000,
                    "fmt": "142.17M",
                    "longFmt": "142,170,000"
                  },
                  "earnings": {
                    "raw": -1626000,
                    "fmt": "-1.63M",
                    "longFmt": "-1,626,000"
                  }
                },
                {
                  "date": "2Q2021",
                  "revenue": {
                    "raw": 154488000,
                    "fmt": "154.49M",
                    "longFmt": "154,488,000"
                  },
                  "earnings": {
                    "raw": 7808000,
                    "fmt": "7.81M",
                    "longFmt": "7,808,000"
                  }
                },
                {
                  "date": "3Q2021",
                  "revenue": {
                    "raw": 142038000,
                    "fmt": "142.04M",
                    "longFmt": "142,038,000"
                  },
                  "earnings": {
                    "raw": -13151000,
                    "fmt": "-13.15M",
                    "longFmt": "-13,151,000"
                  }
                }
              ]
            },
            "financialCurrency": "USD"
          },
          "price": {
            "quoteSourceName": "Nasdaq Real Time Price",
            "regularMarketOpen": {
              "raw": 3.52,
              "fmt": "3.5200"
            },
            "averageDailyVolume3Month": {
              "raw": 4240309,
              "fmt": "4.24M",
              "longFmt": "4,240,309"
            },
            "exchange": "NGM",
            "regularMarketTime": 1645027239,
            "volume24Hr": {},
            "regularMarketDayHigh": {
              "raw": 3.53,
              "fmt": "3.5300"
            },
            "shortName": "Amarin Corporation plc",
            "averageDailyVolume10Day": {
              "raw": 2540660,
              "fmt": "2.54M",
              "longFmt": "2,540,660"
            },
            "longName": "Amarin Corporation plc",
            "regularMarketChange": {
              "raw": -0.08049989,
              "fmt": "-0.0805"
            },
            "currencySymbol": "$",
            "regularMarketPreviousClose": {
              "raw": 3.58,
              "fmt": "3.5800"
            },
            "preMarketPrice": {
              "raw": 3.61,
              "fmt": "3.6100"
            },
            "preMarketTime": 1645021572,
            "exchangeDataDelayedBy": 0,
            "toCurrency": null,
            "postMarketChange": {},
            "postMarketPrice": {},
            "exchangeName": "NasdaqGM",
            "preMarketChange": {
              "raw": 0.03,
              "fmt": "0.03"
            },
            "circulatingSupply": {},
            "regularMarketDayLow": {
              "raw": 3.4,
              "fmt": "3.4000"
            },
            "priceHint": {
              "raw": 4,
              "fmt": "4",
              "longFmt": "4"
            },
            "currency": "USD",
            "regularMarketPrice": {
              "raw": 3.4995,
              "fmt": "3.4995"
            },
            "regularMarketVolume": {
              "raw": 984771,
              "fmt": "984.77k",
              "longFmt": "984,771.00"
            },
            "lastMarket": null,
            "regularMarketSource": "FREE_REALTIME",
            "openInterest": {},
            "marketState": "REGULAR",
            "underlyingSymbol": null,
            "marketCap": {
              "raw": 1385193088,
              "fmt": "1.39B",
              "longFmt": "1,385,193,088.00"
            },
            "quoteType": "EQUITY",
            "preMarketChangePercent": {
              "raw": 0.00837988,
              "fmt": "0.84%"
            },
            "volumeAllCurrencies": {},
            "strikePrice": {},
            "symbol": "AMRN",
            "preMarketSource": "FREE_REALTIME",
            "maxAge": 1,
            "fromCurrency": null,
            "regularMarketChangePercent": {
              "raw": -0.022486003,
              "fmt": "-2.25%"
            }
          },
          "fundOwnership": {
            "maxAge": 1,
            "ownershipList": [
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1635638400,
                  "fmt": "2021-10-31"
                },
                "organization": "Legg Mason Glb Asset Mgt Tr-Clearbridge Small Cap Fd",
                "pctHeld": {
                  "raw": 0.0073,
                  "fmt": "0.73%"
                },
                "position": {
                  "raw": 2899059,
                  "fmt": "2.9M",
                  "longFmt": "2,899,059"
                },
                "value": {
                  "raw": 13828511,
                  "fmt": "13.83M",
                  "longFmt": "13,828,511"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1632960000,
                  "fmt": "2021-09-30"
                },
                "organization": "Value Line Capital Appreciation Fund",
                "pctHeld": {
                  "raw": 0.0043,
                  "fmt": "0.43%"
                },
                "position": {
                  "raw": 1700000,
                  "fmt": "1.7M",
                  "longFmt": "1,700,000"
                },
                "value": {
                  "raw": 8670000,
                  "fmt": "8.67M",
                  "longFmt": "8,670,000"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1632960000,
                  "fmt": "2021-09-30"
                },
                "organization": "Value Line Larger Companies Focused Fund",
                "pctHeld": {
                  "raw": 0.003,
                  "fmt": "0.30%"
                },
                "position": {
                  "raw": 1200000,
                  "fmt": "1.2M",
                  "longFmt": "1,200,000"
                },
                "value": {
                  "raw": 6120000,
                  "fmt": "6.12M",
                  "longFmt": "6,120,000"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1632960000,
                  "fmt": "2021-09-30"
                },
                "organization": "Guardian VP Tr-Guardian Small Cap Core VIP Fd",
                "pctHeld": {
                  "raw": 0.0019,
                  "fmt": "0.19%"
                },
                "position": {
                  "raw": 752186,
                  "fmt": "752.19k",
                  "longFmt": "752,186"
                },
                "value": {
                  "raw": 3836148,
                  "fmt": "3.84M",
                  "longFmt": "3,836,148"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1632960000,
                  "fmt": "2021-09-30"
                },
                "organization": "Columbia Fds Var Ser Tr II-Columbia Var Port-Overseas Core Fd",
                "pctHeld": {
                  "raw": 0.0013,
                  "fmt": "0.13%"
                },
                "position": {
                  "raw": 517951,
                  "fmt": "517.95k",
                  "longFmt": "517,951"
                },
                "value": {
                  "raw": 2641550,
                  "fmt": "2.64M",
                  "longFmt": "2,641,550"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1638230400,
                  "fmt": "2021-11-30"
                },
                "organization": "VanEck ETF Trust-VanEck Pharmaceutical ETF",
                "pctHeld": {
                  "raw": 0.0011999999,
                  "fmt": "0.12%"
                },
                "position": {
                  "raw": 477524,
                  "fmt": "477.52k",
                  "longFmt": "477,524"
                },
                "value": {
                  "raw": 1719086,
                  "fmt": "1.72M",
                  "longFmt": "1,719,086"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1632960000,
                  "fmt": "2021-09-30"
                },
                "organization": "Legg Mason Clearbridge Small Cap Value Fd",
                "pctHeld": {
                  "raw": 0.00090000004,
                  "fmt": "0.09%"
                },
                "position": {
                  "raw": 372770,
                  "fmt": "372.77k",
                  "longFmt": "372,770"
                },
                "value": {
                  "raw": 1901127,
                  "fmt": "1.9M",
                  "longFmt": "1,901,127"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1638230400,
                  "fmt": "2021-11-30"
                },
                "organization": "Columbia Fds Ser Tr-Columbia Overseas Value Fd",
                "pctHeld": {
                  "raw": 0.0008,
                  "fmt": "0.08%"
                },
                "position": {
                  "raw": 311700,
                  "fmt": "311.7k",
                  "longFmt": "311,700"
                },
                "value": {
                  "raw": 1122120,
                  "fmt": "1.12M",
                  "longFmt": "1,122,120"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1638230400,
                  "fmt": "2021-11-30"
                },
                "organization": "Fidelity NASDAQ Composite Index Fund",
                "pctHeld": {
                  "raw": 0.0005,
                  "fmt": "0.05%"
                },
                "position": {
                  "raw": 214385,
                  "fmt": "214.38k",
                  "longFmt": "214,385"
                },
                "value": {
                  "raw": 771786,
                  "fmt": "771.79k",
                  "longFmt": "771,786"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                },
                "organization": "Monetta Fund, Inc.",
                "pctHeld": {
                  "raw": 0.0005,
                  "fmt": "0.05%"
                },
                "position": {
                  "raw": 200000,
                  "fmt": "200k",
                  "longFmt": "200,000"
                },
                "value": {
                  "raw": 674000,
                  "fmt": "674k",
                  "longFmt": "674,000"
                }
              }
            ]
          },
          "insiderTransactions": {
            "transactions": [
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1643587200,
                  "fmt": "2022-01-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 12733,
                  "fmt": "12.73k",
                  "longFmt": "12,733"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1643587200,
                  "fmt": "2022-01-31"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 12733,
                  "fmt": "12.73k",
                  "longFmt": "12,733"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1643587200,
                  "fmt": "2022-01-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 12733,
                  "fmt": "12.73k",
                  "longFmt": "12,733"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 47767,
                  "fmt": "47.77k",
                  "longFmt": "47,767"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 47767,
                  "fmt": "47.77k",
                  "longFmt": "47,767"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 47767,
                  "fmt": "47.77k",
                  "longFmt": "47,767"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "MIKHAIL KARIM",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 11367,
                  "fmt": "11.37k",
                  "longFmt": "11,367"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "ZAKRZEWSKI JOSEPH S",
                "transactionText": "Purchase at price 3.15 - 3.27 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1639526400,
                  "fmt": "2021-12-15"
                },
                "value": {
                  "raw": 38999,
                  "fmt": "39k",
                  "longFmt": "38,999"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 12000,
                  "fmt": "12k",
                  "longFmt": "12,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1630368000,
                  "fmt": "2021-08-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 6108,
                  "fmt": "6.11k",
                  "longFmt": "6,108"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1630368000,
                  "fmt": "2021-08-31"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 6108,
                  "fmt": "6.11k",
                  "longFmt": "6,108"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1630368000,
                  "fmt": "2021-08-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 6108,
                  "fmt": "6.11k",
                  "longFmt": "6,108"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "Sale at price 5.25 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1628726400,
                  "fmt": "2021-08-12"
                },
                "value": {
                  "raw": 630240,
                  "fmt": "630.24k",
                  "longFmt": "630,240"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 120000,
                  "fmt": "120k",
                  "longFmt": "120,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "Conversion of Exercise of derivative security at price 2.19 - 2.95 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1628726400,
                  "fmt": "2021-08-12"
                },
                "value": {
                  "raw": 281800,
                  "fmt": "281.8k",
                  "longFmt": "281,800"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 120000,
                  "fmt": "120k",
                  "longFmt": "120,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1627603200,
                  "fmt": "2021-07-30"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 26944,
                  "fmt": "26.94k",
                  "longFmt": "26,944"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1627603200,
                  "fmt": "2021-07-30"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 7220,
                  "fmt": "7.22k",
                  "longFmt": "7,220"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1627603200,
                  "fmt": "2021-07-30"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 6108,
                  "fmt": "6.11k",
                  "longFmt": "6,108"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1627603200,
                  "fmt": "2021-07-30"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 6108,
                  "fmt": "6.11k",
                  "longFmt": "6,108"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1627603200,
                  "fmt": "2021-07-30"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 6108,
                  "fmt": "6.11k",
                  "longFmt": "6,108"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1625011200,
                  "fmt": "2021-06-30"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 26944,
                  "fmt": "26.94k",
                  "longFmt": "26,944"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1625011200,
                  "fmt": "2021-06-30"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 7220,
                  "fmt": "7.22k",
                  "longFmt": "7,220"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1625011200,
                  "fmt": "2021-06-30"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 6108,
                  "fmt": "6.11k",
                  "longFmt": "6,108"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1625011200,
                  "fmt": "2021-06-30"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 6108,
                  "fmt": "6.11k",
                  "longFmt": "6,108"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1625011200,
                  "fmt": "2021-06-30"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 6108,
                  "fmt": "6.11k",
                  "longFmt": "6,108"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "STACK DAVID M",
                "transactionText": "Purchase at price 4.54 - 4.62 per share.",
                "moneyText": "",
                "ownership": "I",
                "startDate": {
                  "raw": 1622764800,
                  "fmt": "2021-06-04"
                },
                "value": {
                  "raw": 68465,
                  "fmt": "68.47k",
                  "longFmt": "68,465"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 15000,
                  "fmt": "15k",
                  "longFmt": "15,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1622160000,
                  "fmt": "2021-05-28"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 26944,
                  "fmt": "26.94k",
                  "longFmt": "26,944"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1622160000,
                  "fmt": "2021-05-28"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 7220,
                  "fmt": "7.22k",
                  "longFmt": "7,220"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1622160000,
                  "fmt": "2021-05-28"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 6112,
                  "fmt": "6.11k",
                  "longFmt": "6,112"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1622160000,
                  "fmt": "2021-05-28"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 6112,
                  "fmt": "6.11k",
                  "longFmt": "6,112"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1622160000,
                  "fmt": "2021-05-28"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 6112,
                  "fmt": "6.11k",
                  "longFmt": "6,112"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1619740800,
                  "fmt": "2021-04-30"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 26944,
                  "fmt": "26.94k",
                  "longFmt": "26,944"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1619740800,
                  "fmt": "2021-04-30"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 7220,
                  "fmt": "7.22k",
                  "longFmt": "7,220"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1619740800,
                  "fmt": "2021-04-30"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 6112,
                  "fmt": "6.11k",
                  "longFmt": "6,112"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1619740800,
                  "fmt": "2021-04-30"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 6112,
                  "fmt": "6.11k",
                  "longFmt": "6,112"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1619740800,
                  "fmt": "2021-04-30"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 32112,
                  "fmt": "32.11k",
                  "longFmt": "32,112"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1617148800,
                  "fmt": "2021-03-31"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 26944,
                  "fmt": "26.94k",
                  "longFmt": "26,944"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1617148800,
                  "fmt": "2021-03-31"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 7220,
                  "fmt": "7.22k",
                  "longFmt": "7,220"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1617148800,
                  "fmt": "2021-03-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 6112,
                  "fmt": "6.11k",
                  "longFmt": "6,112"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1617148800,
                  "fmt": "2021-03-31"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 6112,
                  "fmt": "6.11k",
                  "longFmt": "6,112"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1617148800,
                  "fmt": "2021-03-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 6112,
                  "fmt": "6.11k",
                  "longFmt": "6,112"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1614297600,
                  "fmt": "2021-02-26"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 477007,
                  "fmt": "477.01k",
                  "longFmt": "477,007"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1614297600,
                  "fmt": "2021-02-26"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 128286,
                  "fmt": "128.29k",
                  "longFmt": "128,286"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1614297600,
                  "fmt": "2021-02-26"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 111060,
                  "fmt": "111.06k",
                  "longFmt": "111,060"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1614297600,
                  "fmt": "2021-02-26"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 111060,
                  "fmt": "111.06k",
                  "longFmt": "111,060"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1614297600,
                  "fmt": "2021-02-26"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 111060,
                  "fmt": "111.06k",
                  "longFmt": "111,060"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "Sale at price 8.03 - 8.06 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1612137600,
                  "fmt": "2021-02-01"
                },
                "value": {
                  "raw": 1754134,
                  "fmt": "1.75M",
                  "longFmt": "1,754,134"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 217728,
                  "fmt": "217.73k",
                  "longFmt": "217,728"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "Conversion of Exercise of derivative security at price 2.50 - 2.95 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1612137600,
                  "fmt": "2021-02-01"
                },
                "value": {
                  "raw": 485882,
                  "fmt": "485.88k",
                  "longFmt": "485,882"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 192358,
                  "fmt": "192.36k",
                  "longFmt": "192,358"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1611878400,
                  "fmt": "2021-01-29"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 209171,
                  "fmt": "209.17k",
                  "longFmt": "209,171"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1611878400,
                  "fmt": "2021-01-29"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 42345,
                  "fmt": "42.34k",
                  "longFmt": "42,345"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "Conversion of Exercise of derivative security at price 1.02 - 3.80 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1611878400,
                  "fmt": "2021-01-29"
                },
                "value": {
                  "raw": 764566,
                  "fmt": "764.57k",
                  "longFmt": "764,566"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 320026,
                  "fmt": "320.03k",
                  "longFmt": "320,026"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1611878400,
                  "fmt": "2021-01-29"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 41789,
                  "fmt": "41.79k",
                  "longFmt": "41,789"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1611878400,
                  "fmt": "2021-01-29"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 15789,
                  "fmt": "15.79k",
                  "longFmt": "15,789"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "Sale at price 8.01 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1611705600,
                  "fmt": "2021-01-27"
                },
                "value": {
                  "raw": 3378131,
                  "fmt": "3.38M",
                  "longFmt": "3,378,131"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 421629,
                  "fmt": "421.63k",
                  "longFmt": "421,629"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1609372800,
                  "fmt": "2020-12-31"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 13472,
                  "fmt": "13.47k",
                  "longFmt": "13,472"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1609372800,
                  "fmt": "2020-12-31"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 3612,
                  "fmt": "3.61k",
                  "longFmt": "3,612"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1609372800,
                  "fmt": "2020-12-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1606694400,
                  "fmt": "2020-11-30"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 13472,
                  "fmt": "13.47k",
                  "longFmt": "13,472"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "STACK DAVID M",
                "transactionText": "Purchase at price 4.86 per share.",
                "moneyText": "",
                "ownership": "I",
                "startDate": {
                  "raw": 1606694400,
                  "fmt": "2020-11-30"
                },
                "value": {
                  "raw": 121518,
                  "fmt": "121.52k",
                  "longFmt": "121,518"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 25000,
                  "fmt": "25k",
                  "longFmt": "25,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1606694400,
                  "fmt": "2020-11-30"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 3612,
                  "fmt": "3.61k",
                  "longFmt": "3,612"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1606694400,
                  "fmt": "2020-11-30"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1606694400,
                  "fmt": "2020-11-30"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1606694400,
                  "fmt": "2020-11-30"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "Sale at price 4.07 - 4.13 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1605052800,
                  "fmt": "2020-11-11"
                },
                "value": {
                  "raw": 2317158,
                  "fmt": "2.32M",
                  "longFmt": "2,317,158"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 567405,
                  "fmt": "567.4k",
                  "longFmt": "567,405"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "Conversion of Exercise of derivative security at price 3.40 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1604966400,
                  "fmt": "2020-11-10"
                },
                "value": {
                  "raw": 2550000,
                  "fmt": "2.55M",
                  "longFmt": "2,550,000"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 750000,
                  "fmt": "750k",
                  "longFmt": "750,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1604016000,
                  "fmt": "2020-10-30"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 13472,
                  "fmt": "13.47k",
                  "longFmt": "13,472"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1604016000,
                  "fmt": "2020-10-30"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 3612,
                  "fmt": "3.61k",
                  "longFmt": "3,612"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1604016000,
                  "fmt": "2020-10-30"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1604016000,
                  "fmt": "2020-10-30"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1604016000,
                  "fmt": "2020-10-30"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "ZAKRZEWSKI JOSEPH S",
                "transactionText": "Conversion of Exercise of derivative security at price 3.40 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1603238400,
                  "fmt": "2020-10-21"
                },
                "value": {
                  "raw": 340000,
                  "fmt": "340k",
                  "longFmt": "340,000"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 100000,
                  "fmt": "100k",
                  "longFmt": "100,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1601424000,
                  "fmt": "2020-09-30"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 13474,
                  "fmt": "13.47k",
                  "longFmt": "13,474"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1601424000,
                  "fmt": "2020-09-30"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 3612,
                  "fmt": "3.61k",
                  "longFmt": "3,612"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1601424000,
                  "fmt": "2020-09-30"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1601424000,
                  "fmt": "2020-09-30"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1601424000,
                  "fmt": "2020-09-30"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1598832000,
                  "fmt": "2020-08-31"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 13472,
                  "fmt": "13.47k",
                  "longFmt": "13,472"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1598832000,
                  "fmt": "2020-08-31"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 3610,
                  "fmt": "3.61k",
                  "longFmt": "3,610"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1598832000,
                  "fmt": "2020-08-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3054,
                  "fmt": "3.05k",
                  "longFmt": "3,054"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1598832000,
                  "fmt": "2020-08-31"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 3054,
                  "fmt": "3.05k",
                  "longFmt": "3,054"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1598832000,
                  "fmt": "2020-08-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3054,
                  "fmt": "3.05k",
                  "longFmt": "3,054"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1596153600,
                  "fmt": "2020-07-31"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 13472,
                  "fmt": "13.47k",
                  "longFmt": "13,472"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1596153600,
                  "fmt": "2020-07-31"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 3610,
                  "fmt": "3.61k",
                  "longFmt": "3,610"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1596153600,
                  "fmt": "2020-07-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3054,
                  "fmt": "3.05k",
                  "longFmt": "3,054"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1596153600,
                  "fmt": "2020-07-31"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 3054,
                  "fmt": "3.05k",
                  "longFmt": "3,054"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1596153600,
                  "fmt": "2020-07-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3054,
                  "fmt": "3.05k",
                  "longFmt": "3,054"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1593475200,
                  "fmt": "2020-06-30"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 13472,
                  "fmt": "13.47k",
                  "longFmt": "13,472"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1593475200,
                  "fmt": "2020-06-30"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 3610,
                  "fmt": "3.61k",
                  "longFmt": "3,610"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1593475200,
                  "fmt": "2020-06-30"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3054,
                  "fmt": "3.05k",
                  "longFmt": "3,054"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1593475200,
                  "fmt": "2020-06-30"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 3054,
                  "fmt": "3.05k",
                  "longFmt": "3,054"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1593475200,
                  "fmt": "2020-06-30"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3054,
                  "fmt": "3.05k",
                  "longFmt": "3,054"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1590710400,
                  "fmt": "2020-05-29"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 13472,
                  "fmt": "13.47k",
                  "longFmt": "13,472"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1590710400,
                  "fmt": "2020-05-29"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 3610,
                  "fmt": "3.61k",
                  "longFmt": "3,610"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1590710400,
                  "fmt": "2020-05-29"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1590710400,
                  "fmt": "2020-05-29"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1590710400,
                  "fmt": "2020-05-29"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1588291200,
                  "fmt": "2020-05-01"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 29056,
                  "fmt": "29.06k",
                  "longFmt": "29,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1588204800,
                  "fmt": "2020-04-30"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 13472,
                  "fmt": "13.47k",
                  "longFmt": "13,472"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1588204800,
                  "fmt": "2020-04-30"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 3610,
                  "fmt": "3.61k",
                  "longFmt": "3,610"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1588204800,
                  "fmt": "2020-04-30"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1588204800,
                  "fmt": "2020-04-30"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1585612800,
                  "fmt": "2020-03-31"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 13472,
                  "fmt": "13.47k",
                  "longFmt": "13,472"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1585612800,
                  "fmt": "2020-03-31"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 3612,
                  "fmt": "3.61k",
                  "longFmt": "3,612"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1585612800,
                  "fmt": "2020-03-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1585612800,
                  "fmt": "2020-03-31"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1585612800,
                  "fmt": "2020-03-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "Sale at price 15.99 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1583280000,
                  "fmt": "2020-03-04"
                },
                "value": {
                  "raw": 3198700,
                  "fmt": "3.2M",
                  "longFmt": "3,198,700"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 200000,
                  "fmt": "200k",
                  "longFmt": "200,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1582848000,
                  "fmt": "2020-02-28"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 13472,
                  "fmt": "13.47k",
                  "longFmt": "13,472"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1582848000,
                  "fmt": "2020-02-28"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 3612,
                  "fmt": "3.61k",
                  "longFmt": "3,612"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1582848000,
                  "fmt": "2020-02-28"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1582848000,
                  "fmt": "2020-02-28"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1582848000,
                  "fmt": "2020-02-28"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 3056,
                  "fmt": "3.06k",
                  "longFmt": "3,056"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1582588800,
                  "fmt": "2020-02-25"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 229030,
                  "fmt": "229.03k",
                  "longFmt": "229,030"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1582588800,
                  "fmt": "2020-02-25"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 61394,
                  "fmt": "61.39k",
                  "longFmt": "61,394"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1582588800,
                  "fmt": "2020-02-25"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 51948,
                  "fmt": "51.95k",
                  "longFmt": "51,948"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1582588800,
                  "fmt": "2020-02-25"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 51948,
                  "fmt": "51.95k",
                  "longFmt": "51,948"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1582588800,
                  "fmt": "2020-02-25"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 51948,
                  "fmt": "51.95k",
                  "longFmt": "51,948"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1580428800,
                  "fmt": "2020-01-31"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 315367,
                  "fmt": "315.37k",
                  "longFmt": "315,367"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1580428800,
                  "fmt": "2020-01-31"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 74734,
                  "fmt": "74.73k",
                  "longFmt": "74,734"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1580428800,
                  "fmt": "2020-01-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 67734,
                  "fmt": "67.73k",
                  "longFmt": "67,734"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1580428800,
                  "fmt": "2020-01-31"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 67734,
                  "fmt": "67.73k",
                  "longFmt": "67,734"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1580428800,
                  "fmt": "2020-01-31"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 41734,
                  "fmt": "41.73k",
                  "longFmt": "41,734"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "ZAKRZEWSKI JOSEPH S",
                "transactionText": "Sale at price 20.94 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1578009600,
                  "fmt": "2020-01-03"
                },
                "value": {
                  "raw": 6282870,
                  "fmt": "6.28M",
                  "longFmt": "6,282,870"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 300000,
                  "fmt": "300k",
                  "longFmt": "300,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "ZAKRZEWSKI JOSEPH S",
                "transactionText": "Conversion of Exercise of derivative security at price 3.40 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1578009600,
                  "fmt": "2020-01-03"
                },
                "value": {
                  "raw": 1020000,
                  "fmt": "1.02M",
                  "longFmt": "1,020,000"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 300000,
                  "fmt": "300k",
                  "longFmt": "300,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "ZAKRZEWSKI JOSEPH S",
                "transactionText": "Sale at price 25.83 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1576454400,
                  "fmt": "2019-12-16"
                },
                "value": {
                  "raw": 2583380,
                  "fmt": "2.58M",
                  "longFmt": "2,583,380"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 100000,
                  "fmt": "100k",
                  "longFmt": "100,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "ZAKRZEWSKI JOSEPH S",
                "transactionText": "Conversion of Exercise of derivative security at price 9.00 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1576454400,
                  "fmt": "2019-12-16"
                },
                "value": {
                  "raw": 900000,
                  "fmt": "900k",
                  "longFmt": "900,000"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 100000,
                  "fmt": "100k",
                  "longFmt": "100,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "Sale at price 23.05 - 25.66 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1576454400,
                  "fmt": "2019-12-16"
                },
                "value": {
                  "raw": 584012,
                  "fmt": "584.01k",
                  "longFmt": "584,012"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 25000,
                  "fmt": "25k",
                  "longFmt": "25,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KALB MICHAEL WAYNE",
                "transactionText": "Conversion of Exercise of derivative security at price 2.19 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1576454400,
                  "fmt": "2019-12-16"
                },
                "value": {
                  "raw": 54750,
                  "fmt": "54.75k",
                  "longFmt": "54,750"
                },
                "filerRelation": "Chief Financial Officer",
                "shares": {
                  "raw": 25000,
                  "fmt": "25k",
                  "longFmt": "25,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "Sale at price 25.46 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1576454400,
                  "fmt": "2019-12-16"
                },
                "value": {
                  "raw": 1101364,
                  "fmt": "1.1M",
                  "longFmt": "1,101,364"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 43253,
                  "fmt": "43.25k",
                  "longFmt": "43,253"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "Conversion of Exercise of derivative security at price 12.60 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1576454400,
                  "fmt": "2019-12-16"
                },
                "value": {
                  "raw": 544988,
                  "fmt": "544.99k",
                  "longFmt": "544,988"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 43253,
                  "fmt": "43.25k",
                  "longFmt": "43,253"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "Sale at price 22.65 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1574121600,
                  "fmt": "2019-11-19"
                },
                "value": {
                  "raw": 6217371,
                  "fmt": "6.22M",
                  "longFmt": "6,217,371"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 274454,
                  "fmt": "274.45k",
                  "longFmt": "274,454"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "EKMAN LARS G",
                "transactionText": "Sale at price 19.35 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1573516800,
                  "fmt": "2019-11-12"
                },
                "value": {
                  "raw": 746759,
                  "fmt": "746.76k",
                  "longFmt": "746,759"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 38600,
                  "fmt": "38.6k",
                  "longFmt": "38,600"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "EKMAN LARS G",
                "transactionText": "Conversion of Exercise of derivative security at price 14.40 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1573516800,
                  "fmt": "2019-11-12"
                },
                "value": {
                  "raw": 555840,
                  "fmt": "555.84k",
                  "longFmt": "555,840"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 38600,
                  "fmt": "38.6k",
                  "longFmt": "38,600"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "Sale at price 17.05 - 17.88 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1573430400,
                  "fmt": "2019-11-11"
                },
                "value": {
                  "raw": 8143452,
                  "fmt": "8.14M",
                  "longFmt": "8,143,452"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 475546,
                  "fmt": "475.55k",
                  "longFmt": "475,546"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "EKMAN LARS G",
                "transactionText": "Sale at price 18.00 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1572912000,
                  "fmt": "2019-11-05"
                },
                "value": {
                  "raw": 115230,
                  "fmt": "115.23k",
                  "longFmt": "115,230"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 6400,
                  "fmt": "6.4k",
                  "longFmt": "6,400"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "EKMAN LARS G",
                "transactionText": "Conversion of Exercise of derivative security at price 14.40 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1572912000,
                  "fmt": "2019-11-05"
                },
                "value": {
                  "raw": 92160,
                  "fmt": "92.16k",
                  "longFmt": "92,160"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 6400,
                  "fmt": "6.4k",
                  "longFmt": "6,400"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "Conversion of Exercise of derivative security at price 2.50 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1572220800,
                  "fmt": "2019-10-28"
                },
                "value": {
                  "raw": 29002,
                  "fmt": "29k",
                  "longFmt": "29,002"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 11601,
                  "fmt": "11.6k",
                  "longFmt": "11,601"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "Stock Award(Grant) at price 0.00 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1570406400,
                  "fmt": "2019-10-07"
                },
                "value": {
                  "raw": 0,
                  "fmt": null,
                  "longFmt": "0"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 1265250,
                  "fmt": "1.27M",
                  "longFmt": "1,265,250"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "Stock Award(Grant) at price 0.00 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1570406400,
                  "fmt": "2019-10-07"
                },
                "value": {
                  "raw": 0,
                  "fmt": null,
                  "longFmt": "0"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 199500,
                  "fmt": "199.5k",
                  "longFmt": "199,500"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KETCHUM STEVEN B",
                "transactionText": "Stock Award(Grant) at price 0.00 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1570406400,
                  "fmt": "2019-10-07"
                },
                "value": {
                  "raw": 0,
                  "fmt": null,
                  "longFmt": "0"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 199500,
                  "fmt": "199.5k",
                  "longFmt": "199,500"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "Stock Award(Grant) at price 0.00 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1570406400,
                  "fmt": "2019-10-07"
                },
                "value": {
                  "raw": 0,
                  "fmt": null,
                  "longFmt": "0"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 199500,
                  "fmt": "199.5k",
                  "longFmt": "199,500"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "EKMAN LARS G",
                "transactionText": "Sale at price 15.01 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1567468800,
                  "fmt": "2019-09-03"
                },
                "value": {
                  "raw": 1365722,
                  "fmt": "1.37M",
                  "longFmt": "1,365,722"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 91016,
                  "fmt": "91.02k",
                  "longFmt": "91,016"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "EKMAN LARS G",
                "transactionText": "Conversion of Exercise of derivative security at price 3.06 - 5.58 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1567468800,
                  "fmt": "2019-09-03"
                },
                "value": {
                  "raw": 320280,
                  "fmt": "320.28k",
                  "longFmt": "320,280"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 91016,
                  "fmt": "91.02k",
                  "longFmt": "91,016"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "Conversion of Exercise of derivative security at price 1.02 - 2.50 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1566345600,
                  "fmt": "2019-08-21"
                },
                "value": {
                  "raw": 300010,
                  "fmt": "300.01k",
                  "longFmt": "300,010"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 191997,
                  "fmt": "192k",
                  "longFmt": "191,997"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "THERO JOHN F",
                "transactionText": "Conversion of Exercise of derivative security at price 1.02 - 2.50 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1566345600,
                  "fmt": "2019-08-21"
                },
                "value": {
                  "raw": 271008,
                  "fmt": "271.01k",
                  "longFmt": "271,008"
                },
                "filerRelation": "Chief Executive Officer",
                "shares": {
                  "raw": 180396,
                  "fmt": "180.4k",
                  "longFmt": "180,396"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "STACK DAVID M",
                "transactionText": "Sale at price 22.28 per share.",
                "moneyText": "",
                "ownership": "I",
                "startDate": {
                  "raw": 1562803200,
                  "fmt": "2019-07-11"
                },
                "value": {
                  "raw": 1158354,
                  "fmt": "1.16M",
                  "longFmt": "1,158,354"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 51991,
                  "fmt": "51.99k",
                  "longFmt": "51,991"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "STACK DAVID M",
                "transactionText": "Conversion of Exercise of derivative security at price 2.19 - 2.50 per share.",
                "moneyText": "",
                "ownership": "I",
                "startDate": {
                  "raw": 1562803200,
                  "fmt": "2019-07-11"
                },
                "value": {
                  "raw": 121035,
                  "fmt": "121.03k",
                  "longFmt": "121,035"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 51991,
                  "fmt": "51.99k",
                  "longFmt": "51,991"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "ZAKRZEWSKI JOSEPH S",
                "transactionText": "Sale at price 23.82 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1562284800,
                  "fmt": "2019-07-05"
                },
                "value": {
                  "raw": 2381580,
                  "fmt": "2.38M",
                  "longFmt": "2,381,580"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 100000,
                  "fmt": "100k",
                  "longFmt": "100,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "ZAKRZEWSKI JOSEPH S",
                "transactionText": "Conversion of Exercise of derivative security at price 9.00 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1562284800,
                  "fmt": "2019-07-05"
                },
                "value": {
                  "raw": 900000,
                  "fmt": "900k",
                  "longFmt": "900,000"
                },
                "filerRelation": "Director",
                "shares": {
                  "raw": 100000,
                  "fmt": "100k",
                  "longFmt": "100,000"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "Sale at price 20.46 - 22.64 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1562112000,
                  "fmt": "2019-07-03"
                },
                "value": {
                  "raw": 2104378,
                  "fmt": "2.1M",
                  "longFmt": "2,104,378"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 98814,
                  "fmt": "98.81k",
                  "longFmt": "98,814"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "BERG AARON D.",
                "transactionText": "Conversion of Exercise of derivative security at price 2.50 - 2.80 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1562112000,
                  "fmt": "2019-07-03"
                },
                "value": {
                  "raw": 255810,
                  "fmt": "255.81k",
                  "longFmt": "255,810"
                },
                "filerRelation": "Officer",
                "shares": {
                  "raw": 98814,
                  "fmt": "98.81k",
                  "longFmt": "98,814"
                },
                "filerUrl": "",
                "maxAge": 1
              },
              {
                "filerName": "KENNEDY JOSEPH T",
                "transactionText": "Sale at price 19.52 per share.",
                "moneyText": "",
                "ownership": "D",
                "startDate": {
                  "raw": 1561939200,
                  "fmt": "2019-07-01"
                },
                "value": {
                  "raw": 1057906,
                  "fmt": "1.06M",
                  "longFmt": "1,057,906"
                },
                "filerRelation": "General Counsel",
                "shares": {
                  "raw": 54186,
                  "fmt": "54.19k",
                  "longFmt": "54,186"
                },
                "filerUrl": "",
                "maxAge": 1
              }
            ],
            "maxAge": 1
          },
          "insiderHolders": {
            "holders": [
              {
                "maxAge": 1,
                "name": "BERG AARON D.",
                "relation": "Officer",
                "url": "",
                "transactionDescription": "Conversion of Exercise of derivative security",
                "latestTransDate": {
                  "raw": 1643587200,
                  "fmt": "2022-01-31"
                },
                "positionDirect": {
                  "raw": 375751,
                  "fmt": "375.75k",
                  "longFmt": "375,751"
                },
                "positionDirectDate": {
                  "raw": 1643587200,
                  "fmt": "2022-01-31"
                }
              },
              {
                "maxAge": 1,
                "name": "EKMAN LARS G",
                "relation": "Director",
                "url": "",
                "transactionDescription": "Sale",
                "latestTransDate": {
                  "raw": 1573516800,
                  "fmt": "2019-11-12"
                },
                "positionDirectDate": {
                  "raw": 1573516800,
                  "fmt": "2019-11-12"
                }
              },
              {
                "maxAge": 1,
                "name": "KALB MICHAEL WAYNE",
                "relation": "Chief Financial Officer",
                "url": "",
                "transactionDescription": "Conversion of Exercise of derivative security",
                "latestTransDate": {
                  "raw": 1643587200,
                  "fmt": "2022-01-31"
                },
                "positionDirect": {
                  "raw": 240627,
                  "fmt": "240.63k",
                  "longFmt": "240,627"
                },
                "positionDirectDate": {
                  "raw": 1643587200,
                  "fmt": "2022-01-31"
                }
              },
              {
                "maxAge": 1,
                "name": "KENNEDY JOSEPH T",
                "relation": "General Counsel",
                "url": "",
                "transactionDescription": "Conversion of Exercise of derivative security",
                "latestTransDate": {
                  "raw": 1627603200,
                  "fmt": "2021-07-30"
                },
                "positionDirect": {
                  "raw": 317860,
                  "fmt": "317.86k",
                  "longFmt": "317,860"
                },
                "positionDirectDate": {
                  "raw": 1627603200,
                  "fmt": "2021-07-30"
                }
              },
              {
                "maxAge": 1,
                "name": "KETCHUM STEVEN B",
                "relation": "Officer",
                "url": "",
                "transactionDescription": "Conversion of Exercise of derivative security",
                "latestTransDate": {
                  "raw": 1643587200,
                  "fmt": "2022-01-31"
                },
                "positionDirect": {
                  "raw": 486087,
                  "fmt": "486.09k",
                  "longFmt": "486,087"
                },
                "positionDirectDate": {
                  "raw": 1643587200,
                  "fmt": "2022-01-31"
                }
              },
              {
                "maxAge": 1,
                "name": "MIKHAIL KARIM",
                "relation": "Chief Executive Officer",
                "url": "",
                "transactionDescription": "Conversion of Exercise of derivative security",
                "latestTransDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                },
                "positionDirect": {
                  "raw": 31031,
                  "fmt": "31.03k",
                  "longFmt": "31,031"
                },
                "positionDirectDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                }
              },
              {
                "maxAge": 1,
                "name": "STACK DAVID M",
                "relation": "Director",
                "url": "",
                "transactionDescription": "Purchase",
                "latestTransDate": {
                  "raw": 1622764800,
                  "fmt": "2021-06-04"
                },
                "positionIndirect": {
                  "raw": 40000,
                  "fmt": "40k",
                  "longFmt": "40,000"
                },
                "positionIndirectDate": {
                  "raw": 1622764800,
                  "fmt": "2021-06-04"
                }
              },
              {
                "maxAge": 1,
                "name": "THERO JOHN F",
                "relation": "Chief Executive Officer",
                "url": "",
                "transactionDescription": "Conversion of Exercise of derivative security",
                "latestTransDate": {
                  "raw": 1627603200,
                  "fmt": "2021-07-30"
                },
                "positionDirect": {
                  "raw": 3252750,
                  "fmt": "3.25M",
                  "longFmt": "3,252,750"
                },
                "positionDirectDate": {
                  "raw": 1627603200,
                  "fmt": "2021-07-30"
                }
              },
              {
                "maxAge": 1,
                "name": "VAN HEEK G JAN",
                "relation": "Director",
                "url": "",
                "transactionDescription": "Sale",
                "latestTransDate": {
                  "raw": 1550793600,
                  "fmt": "2019-02-22"
                },
                "positionDirect": {
                  "raw": 14168,
                  "fmt": "14.17k",
                  "longFmt": "14,168"
                },
                "positionDirectDate": {
                  "raw": 1550793600,
                  "fmt": "2019-02-22"
                }
              },
              {
                "maxAge": 1,
                "name": "ZAKRZEWSKI JOSEPH S",
                "relation": "Director",
                "url": "",
                "transactionDescription": "Purchase",
                "latestTransDate": {
                  "raw": 1639526400,
                  "fmt": "2021-12-15"
                },
                "positionDirect": {
                  "raw": 196547,
                  "fmt": "196.55k",
                  "longFmt": "196,547"
                },
                "positionDirectDate": {
                  "raw": 1639526400,
                  "fmt": "2021-12-15"
                }
              }
            ],
            "maxAge": 1
          },
          "netSharePurchaseActivity": {
            "period": "6m",
            "netPercentInsiderShares": {
              "raw": 0.046,
              "fmt": "4.60%"
            },
            "netInfoCount": {
              "raw": 11,
              "fmt": "11",
              "longFmt": "11"
            },
            "totalInsiderShares": {
              "raw": 5056139,
              "fmt": "5.06M",
              "longFmt": "5,056,139"
            },
            "buyInfoShares": {
              "raw": 223191,
              "fmt": "223.19k",
              "longFmt": "223,191"
            },
            "buyPercentInsiderShares": {
              "raw": 0.046,
              "fmt": "4.60%"
            },
            "sellInfoCount": {
              "raw": 0,
              "fmt": null,
              "longFmt": "0"
            },
            "maxAge": 1,
            "buyInfoCount": {
              "raw": 11,
              "fmt": "11",
              "longFmt": "11"
            },
            "netInfoShares": {
              "raw": 223191,
              "fmt": "223.19k",
              "longFmt": "223,191"
            }
          },
          "majorHoldersBreakdown": {
            "maxAge": 1,
            "insidersPercentHeld": {
              "raw": 0.0127799995,
              "fmt": "1.28%"
            },
            "institutionsPercentHeld": {
              "raw": 0.37293997,
              "fmt": "37.29%"
            },
            "institutionsFloatPercentHeld": {
              "raw": 0.37777,
              "fmt": "37.78%"
            },
            "institutionsCount": {
              "raw": 268,
              "fmt": "268",
              "longFmt": "268"
            }
          },
          "financialData": {
            "ebitdaMargins": {
              "raw": 0.030079998,
              "fmt": "3.01%"
            },
            "profitMargins": {
              "raw": -0.00337,
              "fmt": "-0.34%"
            },
            "grossMargins": {
              "raw": 0.79295,
              "fmt": "79.29%"
            },
            "operatingCashflow": {
              "raw": -76620000,
              "fmt": "-76.62M",
              "longFmt": "-76,620,000"
            },
            "revenueGrowth": {
              "raw": -0.092,
              "fmt": "-9.20%"
            },
            "operatingMargins": {
              "raw": 0.025810001,
              "fmt": "2.58%"
            },
            "ebitda": {
              "raw": 18229000,
              "fmt": "18.23M",
              "longFmt": "18,229,000"
            },
            "targetLowPrice": {
              "raw": 3,
              "fmt": "3.00"
            },
            "recommendationKey": "buy",
            "grossProfits": {
              "raw": 482616000,
              "fmt": "482.62M",
              "longFmt": "482,616,000"
            },
            "freeCashflow": {
              "raw": -59265752,
              "fmt": "-59.27M",
              "longFmt": "-59,265,752"
            },
            "targetMedianPrice": {
              "raw": 10,
              "fmt": "10.00"
            },
            "currentPrice": {
              "raw": 3.4995,
              "fmt": "3.50"
            },
            "earningsGrowth": {},
            "currentRatio": {
              "raw": 2.64,
              "fmt": "2.64"
            },
            "returnOnAssets": {
              "raw": 0.0098,
              "fmt": "0.98%"
            },
            "numberOfAnalystOpinions": {
              "raw": 9,
              "fmt": "9",
              "longFmt": "9"
            },
            "targetMeanPrice": {
              "raw": 9.06,
              "fmt": "9.06"
            },
            "debtToEquity": {
              "raw": 1.628,
              "fmt": "1.63"
            },
            "returnOnEquity": {
              "raw": -0.00327,
              "fmt": "-0.33%"
            },
            "targetHighPrice": {
              "raw": 19,
              "fmt": "19.00"
            },
            "totalCash": {
              "raw": 479142016,
              "fmt": "479.14M",
              "longFmt": "479,142,016"
            },
            "totalDebt": {
              "raw": 10459000,
              "fmt": "10.46M",
              "longFmt": "10,459,000"
            },
            "totalRevenue": {
              "raw": 605947008,
              "fmt": "605.95M",
              "longFmt": "605,947,008"
            },
            "totalCashPerShare": {
              "raw": 1.211,
              "fmt": "1.21"
            },
            "financialCurrency": "USD",
            "maxAge": 86400,
            "revenuePerShare": {
              "raw": 1.536,
              "fmt": "1.54"
            },
            "quickRatio": {
              "raw": 1.723,
              "fmt": "1.72"
            },
            "recommendationMean": {
              "raw": 2.3,
              "fmt": "2.30"
            }
          },
          "quoteType": {
            "exchange": "NGM",
            "shortName": "Amarin Corporation plc",
            "longName": "Amarin Corporation plc",
            "exchangeTimezoneName": "America/New_York",
            "exchangeTimezoneShortName": "EST",
            "isEsgPopulated": false,
            "gmtOffSetMilliseconds": "-18000000",
            "quoteType": "EQUITY",
            "symbol": "AMRN",
            "messageBoardId": "finmb_407863",
            "market": "us_market"
          },
          "institutionOwnership": {
            "maxAge": 1,
            "ownershipList": [
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                },
                "organization": "Baker Brothers Advisors, LLC",
                "pctHeld": {
                  "raw": 0.0535,
                  "fmt": "5.35%"
                },
                "position": {
                  "raw": 21169805,
                  "fmt": "21.17M",
                  "longFmt": "21,169,805"
                },
                "value": {
                  "raw": 71342242,
                  "fmt": "71.34M",
                  "longFmt": "71,342,242"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                },
                "organization": "Sarissa Capital Management, LP",
                "pctHeld": {
                  "raw": 0.048600003,
                  "fmt": "4.86%"
                },
                "position": {
                  "raw": 19250000,
                  "fmt": "19.25M",
                  "longFmt": "19,250,000"
                },
                "value": {
                  "raw": 64872500,
                  "fmt": "64.87M",
                  "longFmt": "64,872,500"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                },
                "organization": "BVF Inc.",
                "pctHeld": {
                  "raw": 0.0416,
                  "fmt": "4.16%"
                },
                "position": {
                  "raw": 16459965,
                  "fmt": "16.46M",
                  "longFmt": "16,459,965"
                },
                "value": {
                  "raw": 55470082,
                  "fmt": "55.47M",
                  "longFmt": "55,470,082"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                },
                "organization": "Eversept Partners, LP",
                "pctHeld": {
                  "raw": 0.026700001,
                  "fmt": "2.67%"
                },
                "position": {
                  "raw": 10573302,
                  "fmt": "10.57M",
                  "longFmt": "10,573,302"
                },
                "value": {
                  "raw": 35632027,
                  "fmt": "35.63M",
                  "longFmt": "35,632,027"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                },
                "organization": "SCP Investment, LP",
                "pctHeld": {
                  "raw": 0.0171,
                  "fmt": "1.71%"
                },
                "position": {
                  "raw": 6750000,
                  "fmt": "6.75M",
                  "longFmt": "6,750,000"
                },
                "value": {
                  "raw": 22747500,
                  "fmt": "22.75M",
                  "longFmt": "22,747,500"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1632960000,
                  "fmt": "2021-09-30"
                },
                "organization": "Morgan Stanley",
                "pctHeld": {
                  "raw": 0.016,
                  "fmt": "1.60%"
                },
                "position": {
                  "raw": 6336406,
                  "fmt": "6.34M",
                  "longFmt": "6,336,406"
                },
                "value": {
                  "raw": 32315670,
                  "fmt": "32.32M",
                  "longFmt": "32,315,670"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                },
                "organization": "Avoro Capital Advisors LLC",
                "pctHeld": {
                  "raw": 0.0152,
                  "fmt": "1.52%"
                },
                "position": {
                  "raw": 6000000,
                  "fmt": "6M",
                  "longFmt": "6,000,000"
                },
                "value": {
                  "raw": 20220000,
                  "fmt": "20.22M",
                  "longFmt": "20,220,000"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                },
                "organization": "ClearBridge Investments, LLC",
                "pctHeld": {
                  "raw": 0.012,
                  "fmt": "1.20%"
                },
                "position": {
                  "raw": 4747563,
                  "fmt": "4.75M",
                  "longFmt": "4,747,563"
                },
                "value": {
                  "raw": 15999287,
                  "fmt": "16M",
                  "longFmt": "15,999,287"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                },
                "organization": "Rock Springs Capital Management, LP",
                "pctHeld": {
                  "raw": 0.0112,
                  "fmt": "1.12%"
                },
                "position": {
                  "raw": 4419700,
                  "fmt": "4.42M",
                  "longFmt": "4,419,700"
                },
                "value": {
                  "raw": 14894389,
                  "fmt": "14.89M",
                  "longFmt": "14,894,389"
                }
              },
              {
                "maxAge": 1,
                "reportDate": {
                  "raw": 1640908800,
                  "fmt": "2021-12-31"
                },
                "organization": "DG Capital Management, LLC",
                "pctHeld": {
                  "raw": 0.011,
                  "fmt": "1.10%"
                },
                "position": {
                  "raw": 4344485,
                  "fmt": "4.34M",
                  "longFmt": "4,344,485"
                },
                "value": {
                  "raw": 14640914,
                  "fmt": "14.64M",
                  "longFmt": "14,640,914"
                }
              }
            ]
          },
          "calendarEvents": {
            "maxAge": 1,
            "earnings": {
              "earningsDate": [
                {
                  "raw": 1646132340,
                  "fmt": "2022-03-01"
                }
              ],
              "earningsAverage": {
                "raw": -0.02,
                "fmt": "-0.02"
              },
              "earningsLow": {
                "raw": -0.07,
                "fmt": "-0.07"
              },
              "earningsHigh": {
                "raw": 0.02,
                "fmt": "0.02"
              },
              "revenueAverage": {
                "raw": 141600000,
                "fmt": "141.6M",
                "longFmt": "141,600,000"
              },
              "revenueLow": {
                "raw": 140000000,
                "fmt": "140M",
                "longFmt": "140,000,000"
              },
              "revenueHigh": {
                "raw": 146600000,
                "fmt": "146.6M",
                "longFmt": "146,600,000"
              }
            },
            "exDividendDate": {},
            "dividendDate": {}
          },
          "summaryDetail": {
            "previousClose": {
              "raw": 3.58,
              "fmt": "3.5800"
            },
            "regularMarketOpen": {
              "raw": 3.52,
              "fmt": "3.5200"
            },
            "twoHundredDayAverage": {
              "raw": 4.3774,
              "fmt": "4.3774"
            },
            "trailingAnnualDividendYield": {
              "raw": 0,
              "fmt": "0.00%"
            },
            "payoutRatio": {
              "raw": 0,
              "fmt": "0.00%"
            },
            "volume24Hr": {},
            "regularMarketDayHigh": {
              "raw": 3.53,
              "fmt": "3.5300"
            },
            "navPrice": {},
            "averageDailyVolume10Day": {
              "raw": 2540660,
              "fmt": "2.54M",
              "longFmt": "2,540,660"
            },
            "totalAssets": {},
            "regularMarketPreviousClose": {
              "raw": 3.58,
              "fmt": "3.5800"
            },
            "fiftyDayAverage": {
              "raw": 3.4212,
              "fmt": "3.4212"
            },
            "trailingAnnualDividendRate": {
              "raw": 0,
              "fmt": "0.00"
            },
            "open": {
              "raw": 3.52,
              "fmt": "3.5200"
            },
            "toCurrency": null,
            "averageVolume10days": {
              "raw": 2540660,
              "fmt": "2.54M",
              "longFmt": "2,540,660"
            },
            "expireDate": {},
            "yield": {},
            "algorithm": null,
            "dividendRate": {},
            "exDividendDate": {},
            "beta": {
              "raw": 2.062655,
              "fmt": "2.06"
            },
            "circulatingSupply": {},
            "startDate": {},
            "regularMarketDayLow": {
              "raw": 3.4,
              "fmt": "3.4000"
            },
            "priceHint": {
              "raw": 4,
              "fmt": "4",
              "longFmt": "4"
            },
            "currency": "USD",
            "regularMarketVolume": {
              "raw": 984771,
              "fmt": "984.77k",
              "longFmt": "984,771"
            },
            "lastMarket": null,
            "maxSupply": {},
            "openInterest": {},
            "marketCap": {
              "raw": 1385193088,
              "fmt": "1.39B",
              "longFmt": "1,385,193,088"
            },
            "volumeAllCurrencies": {},
            "strikePrice": {},
            "averageVolume": {
              "raw": 4240309,
              "fmt": "4.24M",
              "longFmt": "4,240,309"
            },
            "priceToSalesTrailing12Months": {
              "raw": 2.2859972,
              "fmt": "2.29"
            },
            "dayLow": {
              "raw": 3.4,
              "fmt": "3.4000"
            },
            "ask": {
              "raw": 3.5,
              "fmt": "3.5000"
            },
            "ytdReturn": {},
            "askSize": {
              "raw": 3000,
              "fmt": "3k",
              "longFmt": "3,000"
            },
            "volume": {
              "raw": 984771,
              "fmt": "984.77k",
              "longFmt": "984,771"
            },
            "fiftyTwoWeekHigh": {
              "raw": 7.87,
              "fmt": "7.8700"
            },
            "forwardPE": {
              "raw": -174.975,
              "fmt": "-174.98"
            },
            "maxAge": 1,
            "fromCurrency": null,
            "fiveYearAvgDividendYield": {},
            "fiftyTwoWeekLow": {
              "raw": 2.79,
              "fmt": "2.7900"
            },
            "bid": {
              "raw": 3.49,
              "fmt": "3.4900"
            },
            "tradeable": false,
            "dividendYield": {},
            "bidSize": {
              "raw": 4000,
              "fmt": "4k",
              "longFmt": "4,000"
            },
            "dayHigh": {
              "raw": 3.53,
              "fmt": "3.5300"
            }
          },
          "symbol": "AMRN",
          "esgScores": {},
          "upgradeDowngradeHistory": {
            "history": [
              {
                "epochGradeDate": 1645006655,
                "firm": "SVB Leerink",
                "toGrade": "Outperform",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1643639948,
                "firm": "SVB Leerink",
                "toGrade": "Outperform",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1631184703,
                "firm": "SVB Leerink",
                "toGrade": "Outperform",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1620816711,
                "firm": "Goldman Sachs",
                "toGrade": "Sell",
                "fromGrade": "Neutral",
                "action": "down"
              },
              {
                "epochGradeDate": 1612177851,
                "firm": "SVB Leerink",
                "toGrade": "Outperform",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1601287572,
                "firm": "SVB Leerink",
                "toGrade": "Outperform",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1598437603,
                "firm": "Piper Sandler",
                "toGrade": "Overweight",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1588598646,
                "firm": "Aegis Capital",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1588587999,
                "firm": "SVB Leerink",
                "toGrade": "Outperform",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1585817240,
                "firm": "Citigroup",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1585676067,
                "firm": "Stifel",
                "toGrade": "Hold",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1585659104,
                "firm": "Oppenheimer",
                "toGrade": "Perform",
                "fromGrade": "Underperform",
                "action": "up"
              },
              {
                "epochGradeDate": 1585654209,
                "firm": "Goldman Sachs",
                "toGrade": "Neutral",
                "fromGrade": "Buy",
                "action": "down"
              },
              {
                "epochGradeDate": 1585646345,
                "firm": "Jefferies",
                "toGrade": "Hold",
                "fromGrade": "Buy",
                "action": "down"
              },
              {
                "epochGradeDate": 1584092487,
                "firm": "Goldman Sachs",
                "toGrade": "Buy",
                "fromGrade": "Neutral",
                "action": "up"
              },
              {
                "epochGradeDate": 1583163508,
                "firm": "Cowen & Co.",
                "toGrade": "Outperform",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1582722640,
                "firm": "Oppenheimer",
                "toGrade": "Underperform",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1582022781,
                "firm": "Citigroup",
                "toGrade": "Buy",
                "fromGrade": "Neutral",
                "action": "up"
              },
              {
                "epochGradeDate": 1578311412,
                "firm": "JP Morgan",
                "toGrade": "Neutral",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1576523549,
                "firm": "Oppenheimer",
                "toGrade": "Underperform",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1576508203,
                "firm": "Stifel",
                "toGrade": "Hold",
                "fromGrade": "Buy",
                "action": "down"
              },
              {
                "epochGradeDate": 1574249344,
                "firm": "Oppenheimer",
                "toGrade": "Underperform",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1574080080,
                "firm": "Citi",
                "toGrade": "Neutral",
                "fromGrade": "Buy",
                "action": "down"
              },
              {
                "epochGradeDate": 1572529285,
                "firm": "Aegis Capital",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1571135970,
                "firm": "Goldman Sachs",
                "toGrade": "Neutral",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1553251840,
                "firm": "Stifel Nicolaus",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1541164830,
                "firm": "Citigroup",
                "toGrade": "Neutral",
                "fromGrade": "Buy",
                "action": "down"
              },
              {
                "epochGradeDate": 1539777585,
                "firm": "Citigroup",
                "toGrade": "Buy",
                "fromGrade": "Buy",
                "action": "main"
              },
              {
                "epochGradeDate": 1537881077,
                "firm": "Jefferies",
                "toGrade": "Buy",
                "fromGrade": "Buy",
                "action": "main"
              },
              {
                "epochGradeDate": 1537874265,
                "firm": "Citigroup",
                "toGrade": "Buy",
                "fromGrade": "Buy",
                "action": "main"
              },
              {
                "epochGradeDate": 1476872074,
                "firm": "Citigroup",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1475656296,
                "firm": "Cantor Fitzgerald",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1475615452,
                "firm": "Cantor Fitzgerald",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1463037254,
                "firm": "Jefferies",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1426145107,
                "firm": "H.C. Wainwright",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "up"
              },
              {
                "epochGradeDate": 1424252755,
                "firm": "SunTrust Robinson Humphrey",
                "toGrade": "Buy",
                "fromGrade": "Neutral",
                "action": "up"
              },
              {
                "epochGradeDate": 1415610000,
                "firm": "Citigroup",
                "toGrade": "Neutral",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1399879752,
                "firm": "Citigroup",
                "toGrade": "Neutral",
                "fromGrade": "Buy",
                "action": "down"
              },
              {
                "epochGradeDate": 1393584370,
                "firm": "Aegis Capital",
                "toGrade": "Hold",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1389888000,
                "firm": "MKM Partners",
                "toGrade": "Neutral",
                "fromGrade": "Buy",
                "action": "down"
              },
              {
                "epochGradeDate": 1383893330,
                "firm": "Citigroup",
                "toGrade": "Buy",
                "fromGrade": "Neutral",
                "action": "up"
              },
              {
                "epochGradeDate": 1383148800,
                "firm": "Leerink Swann",
                "toGrade": "Market Perform",
                "fromGrade": "Outperform",
                "action": "down"
              },
              {
                "epochGradeDate": 1383130853,
                "firm": "Aegis Capital",
                "toGrade": "Hold",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1382080843,
                "firm": "Citigroup",
                "toGrade": "Neutral",
                "fromGrade": "Buy",
                "action": "down"
              },
              {
                "epochGradeDate": 1382025600,
                "firm": "H.C. Wainwright",
                "toGrade": "Neutral",
                "fromGrade": "Buy",
                "action": "down"
              },
              {
                "epochGradeDate": 1381991178,
                "firm": "JP Morgan",
                "toGrade": "Neutral",
                "fromGrade": "Overweight",
                "action": "down"
              },
              {
                "epochGradeDate": 1381990292,
                "firm": "Canaccord Genuity",
                "toGrade": "Hold",
                "fromGrade": "Buy",
                "action": "down"
              },
              {
                "epochGradeDate": 1381943909,
                "firm": "Leerink Swann",
                "toGrade": "Outperform",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1381939883,
                "firm": "Aegis Capital",
                "toGrade": "Hold",
                "fromGrade": "Buy",
                "action": "down"
              },
              {
                "epochGradeDate": 1379401701,
                "firm": "Goldman Sachs",
                "toGrade": "Neutral",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1378280947,
                "firm": "SunTrust Robinson Humphrey",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1376378215,
                "firm": "H.C. Wainwright",
                "toGrade": "Buy",
                "fromGrade": "Neutral",
                "action": "up"
              },
              {
                "epochGradeDate": 1371744899,
                "firm": "Oppenheimer",
                "toGrade": "Perform",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1362380154,
                "firm": "Citigroup",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1357633828,
                "firm": "Jefferies",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1354895044,
                "firm": "Aegis Capital",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1354877921,
                "firm": "Canaccord Genuity",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1354876024,
                "firm": "UBS",
                "toGrade": "Neutral",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1353999120,
                "firm": "Citigroup",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1350293700,
                "firm": "JP Morgan",
                "toGrade": "Overweight",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1349248560,
                "firm": "Wedbush",
                "toGrade": "Neutral",
                "fromGrade": "Outperform",
                "action": "down"
              },
              {
                "epochGradeDate": 1344507000,
                "firm": "Canaccord Genuity",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "main"
              },
              {
                "epochGradeDate": 1341812820,
                "firm": "Aegis Capital",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "init"
              },
              {
                "epochGradeDate": 1340780880,
                "firm": "Jefferies",
                "toGrade": "Buy",
                "fromGrade": "",
                "action": "main"
              }
            ],
            "maxAge": 86400
          },
          "pageViews": {
            "shortTermTrend": "UP",
            "midTermTrend": "UP",
            "longTermTrend": "UP",
            "maxAge": 1
          }
        }
        """
        
        guard let data = jsonString.data(using: .utf8) else {
            return Fail(error: APIError.decodingError(NSError())).eraseToAnyPublisher()
        }
        
        return Just(data)
            .decode(type: StockDetailResponse.self, decoder: JSONDecoder())
            .mapError { APIError.decodingError($0) }
            .eraseToAnyPublisher()
    }
}


