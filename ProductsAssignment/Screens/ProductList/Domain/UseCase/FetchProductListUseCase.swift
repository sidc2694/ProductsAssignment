//
//  FetchProductListUseCase.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 29/05/24.
//

import Foundation
import Combine

protocol FetchProductListUseCaseProtocol {
    func execute(request: ProductsRequest) -> Future<ProductList, APIErrors>
}

class FetchProductListUseCase: FetchProductListUseCaseProtocol {
    private let repository: ProductsRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: ProductsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(request: ProductsRequest) -> Future<ProductList, APIErrors> {
        return Future<ProductList, APIErrors> { promise in
            self.repository.getProductList(request: request)
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
