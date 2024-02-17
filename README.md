#Description Overview

## Currency Selection
Users can choose from a list of supported currencies.

## Currency Pair Selection and Amount Entry
Users can select a currency pair (e.g., USD/RUB) and enter an amount in the source currency. If the amount is empty, the converted amount and exchange rate should also be cleared.

## Currency Conversion
The app recalculates the amount in the target currency based on the current exchange rate. Cached data is used for conversions, with the rate cached until the app is reloaded. It's possible to add a timer for long use cases to refresh the exchange rates automatically. In case of internet disablement, the app should utilize stored currency rates for conversion.

## Automatic Currency Pair Saving
The chosen currency pair is saved locally, enabling automatic pre-filling upon subsequent app launches.

## Conversion History
The app provides an additional screen, "CurrencyConverterHistory," to display the history of all conversions.

## Conversion History Search
Users can search the conversion history by currency type (e.g., USD or RUB). The historical data is stored locally and is accessible in offline mode as well.

By implementing these features, your Currency Converter app will provide a comprehensive and user-friendly experience for currency conversion and tracking.


# Development Overview
For the development of the Currency Converter app, will follow the MVVM (Model-View-ViewModel) architecture pattern. 
Here's an overview of the key components and their responsibilities:

 ViewModel: CurrencyConverterViewModel will act as the ViewModel, responsible for managing the app's business logic, data processing, and interaction with the repository and services. It will expose data bindings and methods for the SwiftUI views to interact with.

Services: have APIService that will handle network requests for online data retrieval and LocalService for offline data storage and retrieval. These services will provide data to the repository.

Repository: CurrencyPairRepository will serve as an intermediary between the ViewModel and services. It will handle data operations, such as fetching currency pairs from the services and storing/retrieving them locally.

UI: SwiftUI will be used for the UI layer. Views will be organized in the Views folder. The UI will interact with the ViewModel using SwiftUI's data bindings and ObservableObject.

Unit Tests: I wrote test only for CurrencyConverterViewModel as example



