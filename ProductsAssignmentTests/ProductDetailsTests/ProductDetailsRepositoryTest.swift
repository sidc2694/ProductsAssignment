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
        let repository = ProductDetailsRepository(apiRequestManager: MockAPIManager.shared)
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

}
