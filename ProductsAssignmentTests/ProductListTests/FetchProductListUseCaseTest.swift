//
//  FetchProductListUseCaseTest.swift
//  ProductsAssignmentTests
//
//  Created by Siddharth Chauhan on 31/05/24.
//

import XCTest
import Combine
@testable import ProductsAssignment

final class FetchProductListUseCaseTest: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    
    func testSuccessFetchProductsUseCaseMock() {
        let useCase = FetchProductListUseCase(repository: ProductsRepository(apiRequestManager: MockAPIManager.shared))
        useCase.execute(request: ProductsRequest(limit: 30, skip: 0))
            .sink { completion in
                switch completion {
                case .failure(let apiErrors):
                    XCTFail(apiErrors.failureReason ?? "Error")
                default: break
                }
            } receiveValue: { productList in
                XCTAssertNotNil(productList)
            }
            .store(in: &cancellables)
    }

}
