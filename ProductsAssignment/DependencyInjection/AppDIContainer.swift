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

    // Object creation for ProductList module
    lazy private var getProductListUseCase: FetchProductListUseCaseProtocol = {
        return FetchProductListUseCase(repository: ProductsRepository(apiRequestManager: apiRequestManager))
    }()

    func getProductDetailsViewModel() -> some (ProductsViewModelInputProtocol & ProductsViewModelOutputProtocol) {
        return ProductsViewModel(fetchProductListUseCase: getProductListUseCase)
    }

    // Object creation for ProductDetails module
    lazy private var getProductDetailsUseCase: FetchProductDetailsUseCaseProtocol = {
        return FetchProductDetailsUseCase(repository: ProductDetailsRepository(apiRequestManager: apiRequestManager))
    }()

    func getProductDetailsViewModel(productId: Int) -> some (ProductDetailsViewModelInputProtocol & ProductDetailsViewModelOutputProtocol) {
        return ProductDetailsViewModel(fetchProductDetailsUseCase: getProductDetailsUseCase, productId: productId)
    }
}
