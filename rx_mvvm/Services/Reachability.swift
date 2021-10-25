//
//  Reachability.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 25.10.2021.
//

import Foundation
import Network

class Reachability {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    
    private var previousStatus: Bool = true
    private(set) var isConnected: Bool = true
    
    static let shared = Reachability()
    
    private init() {
        monitor.pathUpdateHandler = { path in
            let isConnected = path.status == .satisfied
            let statusChanged = self.previousStatus != isConnected
            
            if statusChanged {
                self.isConnected = isConnected
            }
            self.previousStatus = isConnected
        }
    }
    
    func startListening() {
        self.monitor.start(queue: queue)
    }
}
