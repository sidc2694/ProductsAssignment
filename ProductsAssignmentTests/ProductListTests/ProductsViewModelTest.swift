//
//  ProductsViewModelTest.swift
//  ProductsAssignmentTests
//
//  Created by Siddharth Chauhan on 23/05/24.
//

import XCTest
import Combine
@testable import ProductsAssignment

final class ProductsViewModelTest: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    private var sut: ProductsViewModel!
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testSuccessFetchProductsMock() {
        let useCase = FetchProductListUseCase(repository: ProductsRepository(apiRequestManager: MockAPIManager.shared))
        sut = ProductsViewModel(fetchProductListUseCase: useCase)
        sut.fetchProductList()
        
        switch sut.state {
        case .startLoading:
            break
        case .errorLoading(let error):
            XCTFail("Error: \(error)")
        case .dataLoaded:
            XCTAssert(true)
        }
    }
    
    func testFailureFetchProductsMock() {
        let useCase = FetchProductListUseCase(repository: ProductsRepository(apiRequestManager: MockAPIManager(isCheckFailure: true)))
        sut = ProductsViewModel(fetchProductListUseCase: useCase)
        sut.fetchProductList()
        
        switch sut.state {
        case .startLoading:
            break
        case .errorLoading(let error):
            XCTAssertEqual(error, "Decoding of response failed")
        case .dataLoaded:
            XCTFail()
            
        }
    }
}
