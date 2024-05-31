//
//  ShowProductListView.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 26/05/24.
//

import SwiftUI
import Combine

struct ShowProductListView<ViewModel>: View where ViewModel: ProductsViewModelProtocol {
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(alignment: .center) {
                List {
                    ForEach(viewModel.productList) { product in
                        ProductCellView(productCell: viewModel.createProductCellData(product: product))
                            .onAppear(perform: {
                                print(product.id)
                                viewModel.loadMoreContent(currentItem: product)
                            })
                            .onTapGesture {
                                coordinator.push(.productDetails(product.id))
                            }
                            .listRowBackground(Color.orange.opacity(0.15))
                    }
                } //: List
                .scrollContentBackground(.hidden)
                .alert(viewModel.alertMessage, isPresented: $viewModel.showingAlert) {
                    Button(Constants.Labels.ok, role: .cancel) { }
                }
                .listRowSpacing(15)
            }
            .modifier(NavigationModifiers(title: Constants.ScreenTitles.products))
        }
    }
}

#Preview {
    ShowProductListView(viewModel: ProductsViewModel(fetchProductListUseCase: FetchProductListUseCase(repository: ProductsRepository())))
}
