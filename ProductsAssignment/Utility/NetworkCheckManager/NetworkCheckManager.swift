//
//  NetworkCheckManager.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 24/05/24.
//

import Network
import Foundation

// NetworkCheckManager checks for internet connection of the application.
final class NetworkCheckManager {
    static let shared = NetworkCheckManager()
    
    private let monitor = NWPathMonitor()
    
    var isInternetAvailable = true
    var networkConnectionUpdated: ((Bool) -> Void)?
    
    private init() {
        checkNetworkConnectivity()
    }
    
    func checkNetworkConnectivity() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            if path.status == .satisfied {
                self.isInternetAvailable = true
            } else {
                self.isInternetAvailable = false
            }
            self.networkConnectionUpdated?(self.isInternetAvailable)
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
