//
//  ProductListScreen.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 21/05/24.
//

import SwiftUI

struct ProductsView<ViewModel>: View where ViewModel: ProductsViewModelProtocol {
    @StateObject private var viewModel: ViewModel
    private var output: Output

    /// Custom initializer to inject view model dependecy
    /// - Parameters:
    ///   - productsScreenViewModel: Injecting dependency of ProductsViewModelProtocol type to make it loosely coupled with view model class and expose only those methods which are relevant for this view.
    init(productsScreenViewModel: ViewModel, output: Output) {
        _viewModel = StateObject(wrappedValue: productsScreenViewModel)
        self.output = output
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
            ShowProductListView(viewModel: viewModel, output: output)
        }
    }
}

#Preview {
    ProductsView(productsScreenViewModel: ProductsViewModel(fetchProductListUseCase: FetchProductListUseCase(repository: ProductsRepository(apiRequestManager: MockAPIManager.shared))), output: Output(goToProductDetailsView: { id in }))
}
