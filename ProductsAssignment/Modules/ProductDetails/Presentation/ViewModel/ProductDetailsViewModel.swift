//
//  ProductDetailsViewModel.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 27/05/24.
//

import Foundation
import Combine

// This enum lists all the events that view will receive when view model triggers it.
enum ProductDetailsViewModelEvents {
    case startLoading
    case dataLoaded
    case errorLoading(String)
}

final class ProductDetailsViewModel: ProductDetailsViewModelProtocol {
    let networkCheckHandler = NetworkCheckManager.shared
    
    private(set) var productDetails: ProductDetails!
    
    // View will know only about the action it needs to perform and not the condition because of which that action is performed so adding this state property whch will notify view of doing certain events based on the business logic written in view model.
    @Published private(set) var state: ProductDetailsViewModelEvents = .startLoading
    
    private var productId: Int
    private let fetchProductDetailsUseCase: FetchProductDetailsUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    private var errorMessage: String!
    
    //MARK: - Initializer
    
    // Injecting dependency of APIRequestProtocol to make it testable using mock data.
    init(fetchProductDetailsUseCase: FetchProductDetailsUseCaseProtocol, productId: Int) {
        self.productId = productId
        self.fetchProductDetailsUseCase = fetchProductDetailsUseCase
        
        self.fetchProductDetails()
        self.checkInternetConnection()
    }
}

//MARK: - Network Connection Update
private extension ProductDetailsViewModel {
    /// This method will check for internet connection status update. If internet is not available and productDetails are not available then only it will show error for no internet. Once internet is restored it will call fetchProductDetails() without any user action.
    func checkInternetConnection() {
        networkCheckHandler.networkConnectionUpdated = { [weak self] isInternetAvailable in
            guard let self else { return }
            Task {
                await MainActor.run {
                    if self.productDetails == nil {
                        if isInternetAvailable {
                            self.fetchProductDetails()
                        } else {
                            self.state = .errorLoading(APIErrors.noInternet.failureReason!)
                        }
                    }
                }
            }
        }
    }
}

//MARK: - API Call
extension ProductDetailsViewModel {
    /// Fetches product details with productId.
    func fetchProductDetails() {
        fetchProductDetailsUseCase.execute(productId: productId)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let apiErrors):
                    self.errorMessage = apiErrors.failureReason
                    self.state = .errorLoading(self.errorMessage)
                case .finished:
                    debugPrint("Finished")
                }
            } receiveValue: { [weak self] productDetails in
                guard let self else { return }
                self.productDetails = productDetails
                self.state = .dataLoaded
            }
            .store(in: &cancellables)
            
    }
}
