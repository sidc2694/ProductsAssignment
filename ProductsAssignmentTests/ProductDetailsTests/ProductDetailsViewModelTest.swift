//
//  ProductDetailsViewModelTest.swift
//  ProductsAssignmentTests
//
//  Created by Siddharth Chauhan on 28/05/24.
//

import XCTest
@testable import ProductsAssignment

final class ProductDetailsViewModelTest: XCTestCase {

    private var sut: ProductDetailsViewModel!
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testSuccessFetchProductDetails() {
        let useCase = FetchProductDetailsUseCase(repository: ProductDetailsRepository(apiRequestManager: MockAPIManager.shared))
        sut = ProductDetailsViewModel(fetchProductDetailsUseCase: useCase, productId: 1)
        sut.fetchProductDetails()
        switch sut.state {
        case .startLoading:
            break
        case .errorLoading(let error):
            XCTFail("Error: \(error)")
        case .dataLoaded:
            XCTAssert(true)
            
        }
    }
    
    func testFailureFetchProductDetails() {
        let useCase = FetchProductDetailsUseCase(repository: ProductDetailsRepository(apiRequestManager: MockAPIManager(isCheckFailure: true)))
        sut = ProductDetailsViewModel(fetchProductDetailsUseCase: useCase, productId: 1)
        sut.fetchProductDetails()
        
        switch sut.state {
        case .startLoading:
            break
        case .errorLoading(let error):
            XCTAssertEqual(error, "Decoding of response failed")
        case .dataLoaded:
            XCTFail()
            
        }
    }
    
    func testSuccessFetchProductDetailsMock() {
        let useCase = MockFetchProductDetailsUseCase(isSuccessResponse: true)
        sut = ProductDetailsViewModel(fetchProductDetailsUseCase: useCase, productId: 1)
        sut.fetchProductDetails()
        switch sut.state {
        case .startLoading:
            break
        case .errorLoading(let error):
            XCTFail("Error: \(error)")
        case .dataLoaded:
            XCTAssert(true)
            
        }
    }
    
    func testFailureFetchProductDetailsMock() {
        let useCase = MockFetchProductDetailsUseCase(isSuccessResponse: false)
        sut = ProductDetailsViewModel(fetchProductDetailsUseCase: useCase, productId: 1)
        sut.fetchProductDetails()
        
        switch sut.state {
        case .startLoading:
            break
        case .errorLoading:
            XCTAssert(true)
        case .dataLoaded:
            XCTFail()
            
        }
    }

}
