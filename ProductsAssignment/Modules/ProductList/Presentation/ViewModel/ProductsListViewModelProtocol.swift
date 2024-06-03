//
//  ProductsListViewModelProtocol.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 21/05/24.
//

import Foundation

// ProductsViewModelOutputProtocol and ProductsViewModelInputProtocol contains only those methods and variables of ProductsViewModel which needs to be exposed to the ProductsScreen.
protocol ProductsViewModelOutputProtocol: ObservableObject {
    var productList: [Product] { get }
    var state: ProductsViewModelEvents { get }
    var showingAlert: Bool { get set }
    var alertMessage: String { get }
}

protocol ProductsViewModelInputProtocol: ObservableObject {
    func loadMoreContent(currentItem item: Product)
    func createProductCellData(product: Product) -> ProductCell
    func fetchProductList()
}

typealias ProductsViewModelProtocol = ProductsViewModelOutputProtocol & ProductsViewModelInputProtocol
