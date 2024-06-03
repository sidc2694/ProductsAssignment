//
//  Products.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 21/05/24.
//

import Foundation

struct ProductEntity: Codable {
    let productId: Int!
    let title: String?
    let description: String?
    let price: Double?
    let discountPercentage: Double?
    let thumbnail: String?

    enum CodingKeys: String, CodingKey {

        case productId = "id"
        case title = "title"
        case description = "description"
        case price = "price"
        case discountPercentage = "discountPercentage"
        case thumbnail = "thumbnail"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productId = try values.decodeIfPresent(Int.self, forKey: .productId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        discountPercentage = try values.decodeIfPresent(Double.self, forKey: .discountPercentage)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
    }
}

struct ProductListEntity: Codable {
    let products: [ProductEntity]?
    let total: Int!
    let skip: Int!
    let limit: Int!
}
