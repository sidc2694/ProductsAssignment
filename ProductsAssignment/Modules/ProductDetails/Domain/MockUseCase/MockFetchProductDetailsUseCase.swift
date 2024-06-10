//
//  MockFetchProductDetailsUseCase.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 10/06/24.
//

import Foundation
import Combine

class MockFetchProductDetailsUseCase: FetchProductDetailsUseCaseProtocol {
    private var isSuccessResponse: Bool

    init(isSuccessResponse: Bool) {
        self.isSuccessResponse = isSuccessResponse
    }

    func execute(productId: Int) -> Future<ProductDetails, APIErrors> {
        return Future<ProductDetails, APIErrors> { promise in
            if self.isSuccessResponse {
                let productDetails: ProductDetails = ProductDetails(productId: 1, title: "Essence Mascara Lash Princess", description: "An apple mobile which is nothing like apple", images: [
                    "https://cdn.dummyjson.com/product-images/1/1.jpg",
                    "https://cdn.dummyjson.com/product-images/1/2.jpg",
                    "https://cdn.dummyjson.com/product-images/1/3.jpg",
                    "https://cdn.dummyjson.com/product-images/1/4.jpg",
                    "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"
                ], price: 9.99, discountPercentage: 7.17, stock: 5)
                promise(.success(productDetails))
            } else {
                promise(.failure(APIErrors.decodingFailed))
            }
        }
    }
}
