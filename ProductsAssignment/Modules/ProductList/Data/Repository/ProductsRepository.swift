//
//  ProductsRepository.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 30/05/24.
//

import Foundation
import Combine

class ProductsRepository: ProductsRepositoryProtocol {

    private let apiRequestManager: APIRequestProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer
    // Injecting dependency of APIRequestProtocol to make it testable using mock data.
    init(apiRequestManager: APIRequestProtocol = APIManager.shared) {
        self.apiRequestManager = apiRequestManager
    }

    func getProductList(request: ProductsRequest) -> Future<ProductList, APIErrors> {
        return Future<ProductList, APIErrors> { promise in
            self.apiRequestManager.request(type: ProductListEntity.self, module: Modules.products(request))
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(error))
                    default: break
                    }
                } receiveValue: { [weak self] productEntity in
                    guard let self else { return }
                    if let products = productEntity.products {
                        let productsData: [Product] = products.map({ productEntity in
                            self.createProductDataForDomain(productEntity: productEntity)
                        })
                        promise(.success(ProductList(productList: productsData, total: productEntity.total)))
                    } else {
                        promise(.failure(APIErrors.noDataFound))
                    }
                }
                .store(in: &self.cancellables)
        }
    }

    private func createProductDataForDomain(productEntity: ProductEntity) -> Product {
        Product(
            productId: productEntity.productId,
            title: productEntity.title,
            price: productEntity.price,
            discountPercentage: productEntity.discountPercentage,
            thumbnail: productEntity.thumbnail)
    }
}
