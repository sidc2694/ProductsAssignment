//
//  ProductDetailsEntity.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 30/05/24.
//

import Foundation

struct ProductDetailsEntity: Codable {
    let productId: Int!
    let title: String?
    let description: String?
    let images: [String]?
    let price: Double?
    let discountPercentage: Double?
    let stock: Int?
    
    enum CodingKeys: String, CodingKey {

        case productId = "id"
        case title = "title"
        case description = "description"
        case images = "images"
        case price = "price"
        case discountPercentage = "discountPercentage"
        case stock = "stock"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productId = try values.decodeIfPresent(Int.self, forKey: .productId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        discountPercentage = try values.decodeIfPresent(Double.self, forKey: .discountPercentage)
        stock = try values.decodeIfPresent(Int.self, forKey: .stock)
        images = try values.decodeIfPresent([String].self, forKey: .images)
    }
}
