//
//  ProductsCoordinator.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 10/06/24.
//

import Foundation
import SwiftUI

enum ProductsPage {
    case productList
    case productDetails(Int)
}

final class ProductsCoordinator: CoordinatorProtocol {
    @Binding var navigationPath: NavigationPath

    private var id: UUID
    private var page: ProductsPage
    private var appDIContainer = AppDIContainer()
    
    init(
        page: ProductsPage,
        navigationPath: Binding<NavigationPath>
    ) {
        id = UUID()
        self.page = page
        self._navigationPath = navigationPath
    }

    @ViewBuilder
    func build() -> some View {
        switch self.page {
        case .productList:
            productListView()
        case .productDetails(let id):
            productDetailsView(productId: id)
        }
    }
    
    func push<V>(_ value: V) where V : Hashable {
        navigationPath.append(value)
    }
    
    private func productListView() -> some View {
        let productsView = ProductsView(productsScreenViewModel: appDIContainer.getProductListViewModel(), output: Output(goToProductDetailsView: { id in
            self.push(ProductsCoordinator(page: .productDetails(id), navigationPath: self.$navigationPath))
        }))
        return productsView
    }

    private func productDetailsView(productId: Int) -> some View {
        let productsView = ProductDetailsView(productDetailsScreenViewModel: appDIContainer.getProductDetailsViewModel(productId: productId))
        return productsView
    }
}

extension ProductsCoordinator: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (
        lhs: ProductsCoordinator,
        rhs: ProductsCoordinator
    ) -> Bool {
        lhs.id == rhs.id
    }
}
