//
//  CurrencyButton.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 14.02.24.
//

import SwiftUI


enum CurrencyType: String, Identifiable {
    var id: String {
        return self.rawValue
    }
    case base
    case target
}

struct CurrencyCardView: View {
    
    var title: String
    var action: () -> Void
    @Binding var currency: Currency
    @Binding var amount: String
    var type: CurrencyType = .base
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .foregroundColor(.black)
                        .opacity(0.2)
                        .font(.headline)
                    HStack {
                        Button(action: {
                            action()
                        }, label: {
                            HStack {
                                Image(currency.flag,
                                      bundle: nil)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                
                                Text(currency.title)
                                    .foregroundColor(Color.blue)
                                    .font(.subheadline)
                                Image(systemName: "arrow.up") // Placeholder image, replace with actual image
                            }
                        })
                        Spacer()
                        CustomTextField(text: $amount, isSelected: type == .base ? false : true)
                            .padding(.horizontal, 20)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

struct CurrencyCardView_Preview: PreviewProvider {
    static var previews: some View {
        CurrencyCardView(title: "Preview currency", action: {
            print("action")
        }, currency: .constant(.usd),
        amount: .constant("15"))
    }
}
