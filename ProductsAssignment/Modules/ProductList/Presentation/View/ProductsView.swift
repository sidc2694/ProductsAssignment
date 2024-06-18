//
//  ProductListScreen.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 21/05/24.
//

import SwiftUI

struct ProductsView<ViewModel>: View where ViewModel: ProductsViewModelProtocol {
    @EnvironmentObject private var navigationManager: NavigationManager
    @StateObject private var viewModel: ViewModel

    /// Custom initializer to inject view model dependecy
    /// - Parameters:
    ///   - productsScreenViewModel: Injecting dependency of ProductsViewModelProtocol type to make it loosely coupled with view model class and expose only those methods which are relevant for this view.
    init(productsScreenViewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: productsScreenViewModel)
    }

    var body: some View {
        switch viewModel.state {
        case .startLoading:
            LoadingView()
                .onAppear(perform: {
                    self.viewModel.fetchProductList()
                })
        case .errorLoading(let error):
            ErrorView(error: error)
        case .dataLoaded:
            ShowProductListView(viewModel: viewModel)
                .environmentObject(navigationManager)
        }
    }
}

#Preview {
    ProductsView(productsScreenViewModel: ProductsViewModel(fetchProductListUseCase: FetchProductListUseCase(repository: ProductsRepository(apiRequestManager: MockAPIManager.shared))))
        .environmentObject(NavigationManager(path: NavigationPath()))
}
