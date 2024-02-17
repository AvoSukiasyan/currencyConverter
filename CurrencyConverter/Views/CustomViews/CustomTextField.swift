//
//  CustomTextField.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 14.02.24.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    
    var isSelected = true
    
    var body: some View {
        TextField("amount", text: $text)
            .fixedSize()
            .frame(width: 110, height: 35)
            .background(Color.gray.brightness(0.3))
            .cornerRadius(8)
            .disabled(isSelected).keyboardType(.numberPad)
            .onChange(of: text) { newValue in
                if newValue.count > 6 {
                    text = String(newValue.prefix(6))
                }
            }
    }
}

#Preview {
    CustomTextField(text: .constant("35.98"))
}
