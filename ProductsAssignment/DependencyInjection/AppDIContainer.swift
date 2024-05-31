//
//  AppDIContainer.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 30/05/24.
//

import Foundation

final class AppDIContainer {
    
    lazy private var apiRequestManager: APIRequestProtocol = {
        return APIManager.shared
    }()

    lazy var fetchProductListUseCase: FetchProductListUseCaseProtocol = {
        return FetchProductListUseCase(repository: ProductsRepository(apiRequestManager: apiRequestManager))
    }()
    
    func getProductDetailsViewModel() -> some (ProductsViewModelInputProtocol & ProductsViewModelOutputProtocol) {
        return ProductsViewModel(fetchProductListUseCase: fetchProductListUseCase)
    }
    
    lazy var fetchProductDetailsUseCase: FetchProductDetailsUseCaseProtocol = {
        return FetchProductDetailsUseCase(repository: ProductDetailsRepository(apiRequestManager: apiRequestManager))
    }()
    
    func getProductDetailsViewModel(productId: Int) -> some (ProductDetailsViewModelInputProtocol & ProductDetailsViewModelOutputProtocol) {
        return ProductDetailsViewModel(fetchProductDetailsUseCase: fetchProductDetailsUseCase, productId: productId)
    }
}
