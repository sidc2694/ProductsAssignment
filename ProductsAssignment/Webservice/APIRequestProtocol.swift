//
//  APIRequestProtocol.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 21/05/24.
//

import Foundation
import Combine

// APIRequestProtocol makes webservice calls testable by mocking responses for testing purpose.
protocol APIRequestProtocol {
    func request<T: Codable>(type: T.Type,
                             module: Modules) -> Future<T, APIErrors>
}
