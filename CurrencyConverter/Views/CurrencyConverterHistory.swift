//
//  CurrencyConverterHistory.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 15.02.24.
//

import SwiftUI

import SwiftUI

struct CurrencyConverterHistory: View {
    
    @Binding var history: [CurrencyConversion]
    @State private var searchText = ""
    
    var searchResults: [CurrencyConversion] {
        if searchText.isEmpty {
            return history
        } else {
            return history.filter { item in
                item.from.rawValue.lowercased().contains(searchText.lowercased()) ||
                item.to.rawValue.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                SearchBar(text: $searchText)
                List {
                    ForEach(searchResults) { item in
                        HistoryItemView(item: item)
                    }
                }
                .listRowSpacing(5)
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HistoryItemView: View {
    var item: CurrencyConversion
    
    var body: some View {
        HStack {
            Text("from").font(.footnote)
            Spacer()
            CurrencyInfoView(currency: item.from, amount: item.amount)
            Spacer()
            Text("to").font(.footnote)
            Spacer()
            CurrencyInfoView(currency: item.to, amount: item.convertedAmount)
            Spacer()
        }
    }
}

struct CurrencyInfoView: View {
    var currency: Currency
    var amount: String?
    
    var body: some View {
        VStack {
            Image(currency.flag, bundle: nil)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 35, height: 35)
                .clipShape(Circle())
            HStack {
                Text(currency.rawValue).font(.subheadline)
                if let amount = amount {
                    Text(amount).font(.subheadline)
                }
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(.horizontal, 8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
        }
    }
}

struct CurrencyConverterHistory_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyConverterHistory(history: .constant(
            [CurrencyConversion(from: .rub,to: .eur, 
                                amount: "35.67", rate:2,
                                convertedAmount: "874,6"),
            CurrencyConversion(from: .usd, 
                               to: .cny,
                               amount: "35.67",
                               rate: 2, convertedAmount: "874,6")
        ]))
    }
}
