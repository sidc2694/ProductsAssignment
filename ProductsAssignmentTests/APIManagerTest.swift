//
//  APIManagerTest.swift
//  ProductsAssignmentTests
//
//  Created by Siddharth Chauhan on 24/05/24.
//

import XCTest
import Combine
@testable import ProductsAssignment

final class APIManagerTest: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    
    func testSuccessFetchProducts() {
        var isDataLoaded: Bool = false
        var errorMessage: String?
        var arrProducts: [ProductEntity] = []
        let expectation = self.expectation(description: "Fetch products successful")
        
        APIManager.shared.request(type: ProductListEntity.self, module: .products(ProductsRequest(limit: 30)))
            .sink { completion in
                switch completion {
                case .failure(let apiErrors):
                    errorMessage = apiErrors.failureReason ?? Constants.Errors.somethingWentWrong
                    isDataLoaded = false
                case .finished:
                    print("Finished")
                }
            } receiveValue: { productList in
                guard let products = productList.products else {
                    errorMessage = APIErrors.noDataFound.failureReason!
                    isDataLoaded = false
                    return
                }
                arrProducts.append(contentsOf: products)
                if arrProducts.count == 0 {
                    errorMessage = Constants.Errors.noDataFound
                    isDataLoaded = false
                } else {
                    isDataLoaded = true
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
        
        XCTAssertNil(errorMessage)
        XCTAssertEqual(isDataLoaded, true)
    }

}
