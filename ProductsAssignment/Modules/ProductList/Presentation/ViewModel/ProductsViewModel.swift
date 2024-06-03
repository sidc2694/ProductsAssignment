//
//  ProductsViewModel.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 21/05/24.
//

import Foundation
import Combine

// This enum lists all the events that view will receive when view model triggers it.
enum ProductsViewModelEvents {
    case startLoading
    case dataLoaded
    case errorLoading(String)
}

final class ProductsViewModel: ProductsViewModelProtocol {
    let networkCheckHandler = NetworkCheckManager.shared
    private(set) var productList: [Product] = []
    @Published var showingAlert = false
    @Published private(set) var alertMessage: String = ""
    
    // View will know only about the action it needs to perform and not the condition because of which that action is performed so adding this state property whch will notify view of doing certain events based on the business logic written in view model.
    @Published private(set) var state: ProductsViewModelEvents = .startLoading
    
    private let fetchProductListUseCase: FetchProductListUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    private var totalProducts = 0
    private var errorMessage: String!
    
    // Sets true when fetching product list is in progress.
    private var fetchingProducts: Bool = false
    
    //MARK: - Initializer
    init(fetchProductListUseCase: FetchProductListUseCaseProtocol) {
        self.fetchProductListUseCase = fetchProductListUseCase
        self.checkInternetConnection()
    }
    
    func createProductCellData(product: Product) -> ProductCell {
        return ProductCell(
            thumbnailUrl: product.thumbnailUrl,
            title: product.title,
            description: product.description,
            price: product.price,
            finalPrice: product.finalPrice)
    }
}

//MARK: - Network Connection Update
private extension ProductsViewModel {
    /// This method will check for internet connection status update. If internet is not available and productList array is also empty then only it will show error for no internet. Once internet is restored it will call fetchProductList() without any user action.
    func checkInternetConnection() {
        networkCheckHandler.networkConnectionUpdated = { [weak self] isInternetAvailable in
            guard let self else { return }
            Task {
                await MainActor.run {
                    if self.productList.isEmpty {
                        if isInternetAvailable && !self.fetchingProducts {
                            self.fetchProductList()
                        } else {
                            self.state = .errorLoading(APIErrors.noInternet.failureReason!)
                        }
                    }
                }
            }
            
        }
    }
}

//MARK: - PAGINATION
extension ProductsViewModel {
    /// Loads next batch of data when productList's second last element appears and if all the products are not loaded.
    /// - Parameter item: Product type for checking if it is second last element.
    func loadMoreContent(currentItem item: Product) {
        let thresholdIndex = self.productList.index(self.productList.endIndex, offsetBy: -1)
        if thresholdIndex == item.id, productList.count < totalProducts {
            fetchProductList()
        }
    }
}

//MARK: - API Call
extension ProductsViewModel {
    /// Fetches products with request parameters limit and skip. Limit indicates number items to fetch at a time and skip indicates the offset from which items needs to be fetched.
    func fetchProductList() {
        self.fetchingProducts = true
        let request = ProductsRequest(limit: 30, skip: productList.count)
        fetchProductListUseCase.execute(request: request)
            .sink { [weak self] completion in
                guard let self else { return }
                self.fetchingProducts = false
                switch completion {
                case .failure(let apiErrors):
                    self.handleFailure(apiErrors: apiErrors)
                case .finished:
                    debugPrint("Finished")
                }
            } receiveValue: { [weak self] productData in
                guard let self else { return }
                self.fetchingProducts = false
                self.handleSuccess(productList: productData)
            }
            .store(in: &cancellables)
    }
    
    private func handleSuccess(productList: ProductList) {
        self.totalProducts = productList.total
        self.productList.append(contentsOf: productList.productList)
        if self.productList.count == 0 {
            self.state = .errorLoading(Constants.Errors.noDataFound)
        } else {
            self.state = .dataLoaded
        }
    }
    
    private func handleFailure(apiErrors: APIErrors) {
        if self.productList.isEmpty {
            self.errorMessage = apiErrors.failureReason
            self.state = .errorLoading(self.errorMessage)
        } else {
            self.showingAlert = true
            self.alertMessage = apiErrors.failureReason ?? ""
        }
    }
}
