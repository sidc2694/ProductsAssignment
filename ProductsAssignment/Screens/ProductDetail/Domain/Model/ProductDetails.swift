//
//  ProductDetails.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 22/05/24.
//

import Foundation

struct ProductDetails {
    let productId: Int!
    let title: String?
    let description: String?
    let images: [String]?
    let price: Double?
    let discountPercentage: Double?
    let stock: Int?
    let finalPrice: Double?
    
    init(productId: Int!, title: String?, description: String?, images: [String]?, price: Double?, discountPercentage: Double?, stock: Int?) {
        self.productId = productId
        self.title = title
        self.description = description
        self.images = images
        self.price = price
        self.discountPercentage = discountPercentage
        self.stock = stock
        if let price, let discountPercentage {
            self.finalPrice = price - (price * Double(discountPercentage/100))
        } else {
            self.finalPrice = 0.0
        }
    }
}
