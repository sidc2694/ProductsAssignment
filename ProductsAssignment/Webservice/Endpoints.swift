//
//  Endpoints.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 21/05/24.
//

import Foundation

enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path: String { get }
    var baseUrl: String { get }
    var url: URL? { get }
    var method: HttpMethods { get }
    var parameters: Encodable? { get }
    var header: [String: String]? { get }
}

// For mock json files
protocol JsonFileName {
    var jsonFileName: String { get }
}

// List of all the webservice call cases
enum Modules {
    case products(ProductsRequest)
    case productDetails(productId: Int)
}

// Json file names for mock response
extension Modules: JsonFileName {
    var jsonFileName: String {
        switch self {
        case .products:
            return "Products"
        case .productDetails:
            return "ProductDetails"
        }
    }
}

extension Modules: EndPointType {
    
    var path: String {
        switch self {
        case .products:
            return "products"
        case .productDetails(let id):
            return "products/\(id)"
        }
    }
    
    var baseUrl: String {
        return "https://dummyjson.com/"
    }
    
    var url: URL? {
        var urlString = "\(baseUrl)\(path)"
        if method == .get {
            urlString += "?\(createQueryString())"
        }
        return URL(string: urlString)
    }
    
    var method: HttpMethods {
        switch self {
        case .products:
            return .get
        case .productDetails:
            return .get
        }
    }
    
    var parameters: Encodable? {
        
        switch self {
        case .products(let productsRequest):
            return productsRequest
        case .productDetails:
            return nil
        }
    }
    
    // Creates query string for GET requests.
    func createQueryString() -> String {
        var query: String = ""
        if let dict = parameters?.convertToDict() {
            for (key, value) in dict {
                query += "&\(key)=\(value)"
            }
        }
        return query
    }
    
    var header: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
