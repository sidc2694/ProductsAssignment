//
//  Encodable.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 22/05/24.
//

import Foundation

extension Encodable {
    
    // Convert Encodable object to dictionary
    func convertToDict() -> Dictionary<String, Any>? {
        var dict: Dictionary<String, Any>? = nil
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
            
        } catch {
            debugPrint(error)
        }
        return dict
    }
}
