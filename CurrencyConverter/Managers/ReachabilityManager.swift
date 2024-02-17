//
//  ReachabilityManager.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 14.02.24.
//

import Foundation

public final class ReachabilityManager: NSObject {
    
    @objc(sharedManager)
    static let shared: ReachabilityManager = {
        return ReachabilityManager()
    }()
    
    private let reachability = try! Reachability()
    private var connection: Reachability.Connection?
    
    private override init() {
        super.init()
        connection = reachability.connection
        reachability.whenReachable = { [weak self] status in
            self?.postNotification(connection: status.connection)
        }
        
        reachability.whenUnreachable = { [weak self] status in
            self?.postNotification(connection: status.connection)
        }
        startListening()
    }
    
    private func postNotification(connection: Reachability.Connection) {
        guard self.connection != connection else {return}
        self.connection = connection
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ReachabilityChangedLocalNotification"), object: nil)
    }
    
    deinit {
        reachability.stopNotifier()
    }
    
    //MARK: Public
    @objc
    func isReachable() -> Bool {
        return reachability.connection == .unavailable ? false : true
    }
    
    func startListening() {
        try? reachability.startNotifier()
    }
}

