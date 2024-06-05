//
//  ProductList.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 30/05/24.
//

import Foundation

struct ProductList {
    let productList: [Product]!
    let total: Int!
}

struct Product: Identifiable, Hashable {
    let productId: Int!
    let title: String?
    let price: Double?
    let discountPercentage: Double?
    let thumbnail: String?
    var thumbnailUrl: URL?
    let finalPrice: Double!
    var id: Int {
        productId
    }

    init(productId: Int!, title: String?, price: Double?, discountPercentage: Double?, thumbnail: String?) {
        self.productId = productId
        self.title = title
        self.price = price
        self.discountPercentage = discountPercentage
        self.thumbnail = thumbnail
        if let thumbnailString = thumbnail {
            self.thumbnailUrl = URL(string: thumbnailString)
        }
        if let price, let discountPercentage {
            self.finalPrice = price - (price * Double(discountPercentage/100))
        } else {
            self.finalPrice = 0.0
        }
    }
}
