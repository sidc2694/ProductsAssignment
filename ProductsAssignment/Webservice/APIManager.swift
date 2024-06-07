//
//  APIManager.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 21/05/24.
//

import Foundation
import Combine

// MARK: - APIManager
final class APIManager: NSObject, APIRequestProtocol {
    static let shared = APIManager()

    private var networkCheckHandler: NetworkCheckManagerProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer
    private init(networkCheckManager: NetworkCheckManagerProtocol = NetworkCheckManager.shared) {
        self.networkCheckHandler = networkCheckManager
    }

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

            let urlSession = URLSession(configuration: .default, delegate: AppURLSessionDelegate(), delegateQueue: nil)
            // Checks for internet connectivity before making webservice call
            guard self.networkCheckHandler.isInternetAvailable else { return promise(.failure(.noInternet)) }

            urlSession.dataTaskPublisher(for: urlRequest)
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
                        if let apiError = error as? APIErrors {
                            promise(.failure(apiError))
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

final class AppURLSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        challenge.trustServer(completionHandler: completionHandler)
    }
}
