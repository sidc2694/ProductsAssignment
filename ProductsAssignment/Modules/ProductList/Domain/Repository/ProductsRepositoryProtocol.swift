//
//  ProductsRepository.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 29/05/24.
//

import Foundation
import Combine

protocol ProductsRepositoryProtocol {
    func getProductList(request: ProductsRequest) -> Future<ProductList, APIErrors>
}
