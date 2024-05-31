//
//  APIManager.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 21/05/24.
//

import Foundation
import Combine

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

// MARK: - APIManager
final class APIManager: APIRequestProtocol {
    static let shared = APIManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializer
    private init() { }
    
    // MARK: - Request Call
    
    /// Generic method to make webservice call
    /// - Parameters:
    ///   - type: Type of object to be returned
    ///   - module: Enum defining which webservice call to make
    func request<T: Codable>(type: T.Type, module: Modules) -> Future<T, APIErrors> {
        return Future<T, APIErrors> { [weak self] promise in
            guard let self, let url = module.url else {
                return promise(.failure(.invalidUrl))
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = module.method.rawValue
            urlRequest.allHTTPHeaderFields = module.header
            
            // Checks for internet connectivity before making webservice call
            guard NetworkCheckManager.shared.isInternetAvailable else { return promise(.failure(.noInternet)) }
            
            URLSession.shared.dataTaskPublisher(for: urlRequest)
                .receive(on: RunLoop.main)
                .tryMap { (data, response) in
                    guard let responseCode = response as? HTTPURLResponse,
                          200...299 ~= responseCode.statusCode else {
                        throw APIErrors.invalidResponse
                    }
                    
                    let decoder = JSONDecoder()
                    guard let result = try? decoder.decode(T.self, from: data) else {
                        throw APIErrors.decodingFailed
                    }
                    return result
                }
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        if error is APIErrors {
                            promise(.failure(error as! APIErrors))
                        } else {
                            promise(.failure(.network(error)))
                        }
                    default: break
                    }
                } receiveValue: {
                    promise(.success($0))
                }
                .store(in: &self.cancellables)

        }
    }
}
