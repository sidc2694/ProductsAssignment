//
//  FetchProductDetailsUseCaseTest.swift
//  ProductsAssignmentTests
//
//  Created by Siddharth Chauhan on 31/05/24.
//

import XCTest
import Combine
@testable import ProductsAssignment

final class FetchProductDetailsUseCaseTest: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    func testSuccessFetchProductDetailsUseCaseMock() {
        let useCase = MockFetchProductDetailsUseCase(isSuccessResponse: true)
        useCase.execute(productId: 1)
            .sink { completion in
                switch completion {
                case .failure(let apiErrors):
                    XCTFail(apiErrors.failureReason ?? "Error")
                default: break
                }
            } receiveValue: { productDetails in
                XCTAssertNotNil(productDetails)
            }
            .store(in: &cancellables)
    }
    
    func testFailureFetchProductDetailsUseCaseMock() {
        let useCase = MockFetchProductDetailsUseCase(isSuccessResponse: false)
        useCase.execute(productId: 1)
            .sink { completion in
                switch completion {
                case .failure:
                    XCTAssert(true)
                default: break
                }
            } receiveValue: { productDetails in
                XCTFail()
            }
            .store(in: &cancellables)
    }
}
