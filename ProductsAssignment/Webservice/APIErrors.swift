//
//  APIErrors.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 03/06/24.
//

import Foundation

// List of all the possible errors that can occur while making webservice request.
enum APIErrors: Error {
    case invalidUrl
    case invalidData
    case invalidBody
    case invalidResponse
    case network(Error?)
    case decodingFailed
    case noInternet
    case noDataFound
    case unknown
}

extension APIErrors: LocalizedError {
    var failureReason: String? {
        switch self {
        case .invalidUrl:
            return Constants.Errors.invalidUrl
        case .invalidData:
            return Constants.Errors.invalidData
        case .invalidBody:
            return Constants.Errors.invalidBody
        case .invalidResponse:
            return Constants.Errors.invalidResponse
        case .network(let error):
            return error?.localizedDescription
        case .decodingFailed:
            return Constants.Errors.decodingFailed
        case .noInternet:
            return Constants.Errors.noInternetAvailable
        case .noDataFound:
            return Constants.Errors.noDataFound
        case .unknown:
            return Constants.Errors.somethingWentWrong
        }
    }
}
