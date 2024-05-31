//
//  ProductsRepositoryTest.swift
//  ProductsAssignmentTests
//
//  Created by Siddharth Chauhan on 31/05/24.
//

import XCTest
import Combine
@testable import ProductsAssignment

final class ProductsRepositoryTest: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    
    func testSuccessProductsRepositoryMock() {
        let repository = ProductsRepository(apiRequestManager: MockAPIManager.shared)
        repository.getProductList(request: ProductsRequest(limit: 30, skip: 0))
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail(error.failureReason ?? "Error")
                default: break
                }
            } receiveValue: { productList in
                XCTAssertNotNil(productList)
            }
            .store(in: &self.cancellables)
    }
}
