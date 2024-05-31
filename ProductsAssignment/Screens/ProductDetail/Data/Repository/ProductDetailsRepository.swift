//
//  ProductDetailsRepository.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 29/05/24.
//

import Foundation
import Combine

class ProductDetailsRepository: ProductDetailsRepositoryProtocol {
    
    private let apiRequestManager: APIRequestProtocol
    private var cancellables = Set<AnyCancellable>()
    // MARK: - Initializer
    // Injecting dependency of APIRequestProtocol to make it testable using mock data.
    init(apiRequestManager: APIRequestProtocol = APIManager.shared) {
        self.apiRequestManager = apiRequestManager
    }
    
    func getProductList(productId: Int) -> Future<ProductDetails, APIErrors> {
        return Future<ProductDetails, APIErrors> { promise in
            self.apiRequestManager.request(type: ProductDetailsEntity.self, module: Modules.productDetails(productId: productId))
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(error))
                    default: break
                    }
                } receiveValue: { [weak self] details in
                    guard let self else { return }
                    promise(.success(self.createProductDetailsForDomain(details: details)))
                }
                .store(in: &self.cancellables)
        }
    }
    
    private func createProductDetailsForDomain(details: ProductDetailsEntity) -> ProductDetails {
        ProductDetails(
            productId: details.productId,
            title: details.title,
            description: details.description,
            images: details.images,
            price: details.price,
            discountPercentage: details.discountPercentage,
            stock: details.stock)
    }
}
