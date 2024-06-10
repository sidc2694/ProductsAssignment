//
//  AppNavigationManager.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 22/05/24.
//

import SwiftUI

enum Page: Hashable {
    case productList
    case productDetails(Int)

    var pageIdentifier: String {
        switch self {
        case .productList:
            return "productList"
        case .productDetails:
            return "productDetails"
        }
    }

    var id: String {
        self.pageIdentifier
    }
}

final class NavigationManager: ObservableObject, NavigationManagerProtocol {

    @Published var path: NavigationPath

    private var appDIContainer = AppDIContainer()

    init(path: NavigationPath) {
        self.path = path
    }

    func push(_ page: Page) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .productList:
            ProductsView(productsScreenViewModel: appDIContainer.getProductDetailsViewModel())
        case .productDetails(let productId):
            ProductDetailsView(productDetailsScreenViewModel: appDIContainer.getProductDetailsViewModel(productId: productId))
        }
    }
}
