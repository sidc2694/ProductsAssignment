//
//  MockAPIManager.swift
//  ProductsAssignmentTests
//
//  Created by Siddharth Chauhan on 03/06/24.
//

import Foundation
import Combine

class MockAPIManager: APIRequestProtocol {
    static let shared = MockAPIManager()
    
    private var cancellables = Set<AnyCancellable>()
    private var isCheckFailure = false
    
    // MARK: - Initializer
    init(isCheckFailure: Bool = false) {
        self.isCheckFailure = isCheckFailure
    }
    
    /// Generic method to make webservice call
    /// - Parameters:
    ///   - type: Type of object to be returned
    ///   - module: Enum defining which webservice call to make
    func request<T>(type: T.Type, module: Modules) -> Future<T, APIErrors> where T : Decodable, T : Encodable {
        return Future<T, APIErrors> { [weak self] promise in
            guard let self else { return }
            let jsonFileName = self.isCheckFailure ? "\(module.jsonFileName)_Failure" : module.jsonFileName
            MockJsonHandler.getApiResponse(jsonFileName: jsonFileName)
                .tryMap { (data) in
                    let decoder = JSONDecoder()
                    guard let result = try? decoder.decode(T.self, from: data) else {
                        throw APIErrors.decodingFailed
                    }
                    return result
                }
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(error as! APIErrors))
                    default: break
                    }
                } receiveValue: { promise(.success($0)) }
                .store(in: &self.cancellables)
        }
    }
    
}

// MARK: - MockJsonHandler
final class MockJsonHandler {
    
    class func getApiResponse(jsonFileName: String) -> Future<Data, APIErrors> {
        return Future<Data, APIErrors> { promise in
            let data = readLocalJSONFile(forName: jsonFileName)
            guard let data else { return promise(.failure(.invalidData)) }
            promise(.success(data))
        }
    }
    
    /// Read from JSON file
    /// - Parameter name: Name of JOSN file
    /// - Returns: Return file content in Data format
    private class func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
