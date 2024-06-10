//
//  MockProductsRepository.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 10/06/24.
//

import Foundation
import Combine

class MockProductsRepository: ProductsRepositoryProtocol {
    private var isSuccessResponse: Bool

    init(isSuccessResponse: Bool) {
        self.isSuccessResponse = isSuccessResponse
    }

    func getProductList(request: ProductsRequest) -> Future<ProductList, APIErrors> {
        return Future<ProductList, APIErrors> { promise in
            if self.isSuccessResponse {
                let arrProducts: [Product] = [Product(productId: 1, title:"Essence Mascara Lash Princess", price:9.99, discountPercentage:7.17, thumbnail:"https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png"), Product(productId: 2, title:"Eyeshadow Palette with Mirror", price:19.99, discountPercentage:5.5, thumbnail:"https://cdn.dummyjson.com/products/images/beauty/Eyeshadow%20Palette%20with%20Mirror/thumbnail.png")]
                promise(.success(ProductList(productList: arrProducts, total: 2)))
            } else {
                promise(.failure(APIErrors.noDataFound))
            }
        }
    }
}
