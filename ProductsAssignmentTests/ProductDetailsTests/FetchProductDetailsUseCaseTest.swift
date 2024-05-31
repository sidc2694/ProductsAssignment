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
        let useCase = FetchProductDetailsUseCase(repository: ProductDetailsRepository(apiRequestManager: MockAPIManager.shared))
        useCase.execute(productId: 1)
            .sink { completion in
                switch completion {
                case .failure(let apiErrors):
                    XCTFail(apiErrors.failureReason ?? "Error")
                case .finished:
                    debugPrint("Finished")
                }
            } receiveValue: { productDetails in
                XCTAssertNotNil(productDetails)
            }
            .store(in: &cancellables)
    }

}
