//
//  TypeAliases.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 14.02.24.
//

import Foundation

public enum Response<T> {
  case success(T)
  case failure(Error?)
}

public typealias EmptyCompletion = () -> Void
public typealias CompletionValue<T> = (T) -> Void
public typealias CompletionValueWithError<T> = (_ response: Response<T>) -> Void
