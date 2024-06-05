//
//  ProductDetailsRepositoryProtocol.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 30/05/24.
//

import Foundation
import Combine

protocol ProductDetailsRepositoryProtocol {
    func getProductList(productId: Int) -> Future<ProductDetails, APIErrors>
}
