//
//  NetworkCheckManagerProtocol.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 05/06/24.
//

import Foundation

protocol NetworkCheckManagerProtocol {
    var isInternetAvailable: Bool { get }
    var networkConnectionUpdated: ((Bool) -> Void)? { get set }
}
