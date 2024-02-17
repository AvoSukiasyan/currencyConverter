//
//  UserDefaultsManager.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 16.02.24.
//

import Foundation

// UserDefaults instance
class UserDefaultsManager {
    
    private let userDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func setValue(_ value: Any?, forKey key: String) {
        userDefaults.setValue(value, forKey: key)
    }
    
    func value(forKey key: String) -> Any? {
        return userDefaults.value(forKey: key)
    }
    
    func setArray<T: Codable>(_ array: [T], forKey key: String) {
        if let data = try? encoder.encode(array) {
            userDefaults.set(data, forKey: key)
        }
    }
    
    func getArray<T: Codable>(forKey key: String) -> [T]? {
        if let data = userDefaults.value(forKey: key) as? Data {
            return try? decoder.decode([T].self, from: data)
        }
        return []
    }
    
    func setObject<T: Codable>(_ object: T, forKey key: String) {
        do {
            let data = try encoder.encode(object)
            userDefaults.set(data, forKey: key)
        } catch {
            print("Error encoding object: \(error)")
        }
    }
    
    func getObject<T: Codable>(forKey key: String) -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        do {
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            print("Error decoding object: \(error)")
            return nil
        }
    }
    
    func removeObject(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    // Add more methods as needed for other types of data
    
}
