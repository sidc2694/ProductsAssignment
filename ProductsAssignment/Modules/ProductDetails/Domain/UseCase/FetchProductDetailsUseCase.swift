//
//  FetchProductDetailsUseCase.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 29/05/24.
//

import Foundation
import Combine

protocol FetchProductDetailsUseCaseProtocol {
    func execute(productId: Int) -> Future<ProductDetails, APIErrors>
}

class FetchProductDetailsUseCase: FetchProductDetailsUseCaseProtocol {
    private let repository: ProductDetailsRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: ProductDetailsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(productId: Int) -> Future<ProductDetails, APIErrors> {
        return Future<ProductDetails, APIErrors> { promise in
            self.repository.getProductList(productId: productId)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(error))
                    default: break
                    }
                } receiveValue: {
                    promise(.success($0))
                }
                .store(in: &self.cancellables)
        }
    }
}
