//
//  Constants.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 21/05/24.
//

import Foundation

enum Constants {
    static let applicationName: String = "Products"
    
    enum ScreenTitles {
        static let products = "Products"
        static let productDetails = "Product Details"
    }
    
    enum Labels {
        static let description = "Description"
        static let stock = "%d in a stock"
        static let ok = "OK"
    }
    
    enum Images {
        static let backImage = "arrow.left"
    }
    
    enum Errors {
        static let invalidUrl: String = "Webservice url is invalid"
        static let invalidBody: String = "Request body is invalid"
        static let invalidData: String = "Webservice response data is invalid"
        static let invalidResponse: String = "Webservice response is invalid"
        static let decodingFailed: String = "Decoding of response failed"
        static let somethingWentWrong: String = "Something went wrong"
        static let noInternetAvailable: String = "Internet connection is not available. Please connect to internet."
        static let noDataFound: String = "No data found"
    }
    
}
