//
//  ProductDetailsRepositoryTest.swift
//  ProductsAssignmentTests
//
//  Created by Siddharth Chauhan on 31/05/24.
//

import XCTest
import Combine
@testable import ProductsAssignment

final class ProductDetailsRepositoryTest: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    func testSuccessProductDetailsRepositoryMock() {
        let repository = MockProductDetailsRepository(isSuccessResponse: true)
        repository.getProductList(productId: 1)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail(error.failureReason ?? "Error")
                default: break
                }
            } receiveValue: { productDetails in
                XCTAssertNotNil(productDetails)
            }
            .store(in: &self.cancellables)
    }
    
    func testFailureProductDetailsRepositoryMock() {
        let repository = MockProductDetailsRepository(isSuccessResponse: false)
        repository.getProductList(productId: 1)
            .sink { completion in
                switch completion {
                case .failure:
                    XCTAssert(true)
                default: break
                }
            } receiveValue: { productDetails in
                XCTFail()
            }
            .store(in: &self.cancellables)
    }
}
