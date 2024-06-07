//
//  ProductDetailsViewModelProtocol.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 27/05/24.
//

import Foundation

// ProductDetailsViewModelOutputProtocol and ProductDetailsViewModelInputProtocol contains only those methods and variables of ProductDetailsViewModel which needs to be exposed to the ProductDetailScreen.
protocol ProductDetailsViewModelOutputProtocol: ObservableObject {
    var productDetails: ProductDetails? { get }
    var state: ProductDetailsViewModelEvents { get }
}

protocol ProductDetailsViewModelInputProtocol: ObservableObject {
    func fetchProductDetails()
}

typealias ProductDetailsViewModelProtocol = ProductDetailsViewModelOutputProtocol & ProductDetailsViewModelInputProtocol
