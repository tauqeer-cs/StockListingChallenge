# Moneybase iOS Task

About

1.Listing screen with search which loading the stock from yahoo finanace api
2.Detail screen with selected item details. stock/v2/get-summary is depricated to to check had used mock data to make design but with real api its always 204 and screen shows fallback design with data that comes from listing
3.Design is make using SwiftUI
4.Used to external Dependencies. 
5.Covered tests for ViewModels

What more could have been dont if had more time
1.We could have create selection option for different regions
2.Could have covered more tests specially views if we used something like ViewInspector

Folder/Code Structure


App
    - MoneyBaseStockListingChallengeApp: The main entry point of the SwiftUI app.

Models

    - MarketSummaryResponse: Model representing market summary data.
    - StockDetailResponse: Model that represents detailed stock information.

Repositories 

    - ApiClientRepository: Responsible for making network requests.
    - StockRepository: Manages stock-related api call fetching.

Resources

    - Assets , localized strings.

Utils (Utility classes/helpers)

    - ApiConfig: Configuration for API endpoints.
    - ShimmerEffectModifier: SwiftUI modifier for a shimmering loading effect.

ViewModels 

    - StockListViewModel: Manages stock listing data.
    - StockDetailViewModel: Handles data and logic for stock details.

Views

    - StockListingView: Shows a list of stocks.
    - StockDetailView: Displays details of a stock.





