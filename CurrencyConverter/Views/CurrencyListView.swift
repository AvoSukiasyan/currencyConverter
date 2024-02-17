//
//  CurrencyListView.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 14.02.24.
//

import SwiftUI

import SwiftUI

struct CurrencyListView: View {
    @Binding var selectedItem: Currency
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List(Currency.allValues, id: \.self) { currency in
            CurrencyRow(currency: currency, isSelected: currency == selectedItem)
                .onTapGesture {
                    selectedItem = currency
                    dismiss()
                }
        }
        .listRowSpacing(10)
    }
}

struct CurrencyRow: View {
    let currency: Currency
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Image(currency.flag, bundle: nil)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 32, height: 25)
                .clipShape(Circle())
            Text(currency.title)
            Spacer()
        }
        .foregroundColor(isSelected ? .blue : .primary)
    }
}


#Preview {
    CurrencyListView(selectedItem: .constant(Currency.usd))
}
