//
//  ProductsScreenTest.swift
//  ProductAssignmentUITests
//
//  Created by Siddharth Chauhan on 24/05/24.
//

import XCTest
@testable import ProductsAssignment

final class ScreenNavigationTest: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testNavigateToProductDetailsScreen() {
        app.collectionViews.staticTexts["Powder Canister"].tap()
        XCTAssert(app.navigationBars["Product Details"].exists, "We are not on Product Details screen")
    }
    
    func testNavigateBackFromProductDetailsScreen() {
        app.collectionViews.staticTexts["Powder Canister"].tap()
        if app.navigationBars["Product Details"].exists {
            app.navigationBars["Product Details"].buttons["Left"].tap()
            XCTAssert(app.navigationBars["Products"].exists, "We are not on Product screen")
        } else {
            XCTFail()
        }
    }
}
