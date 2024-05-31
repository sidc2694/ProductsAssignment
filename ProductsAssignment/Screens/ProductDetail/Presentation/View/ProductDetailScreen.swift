//
//  ProductDetailScreen.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 22/05/24.
//

import SwiftUI

struct ProductDetailScreen<ViewModel>: View where ViewModel: ProductDetailsViewModelProtocol {
    
    @StateObject private var viewModel: ViewModel
    
    /// Custom initializer to inject view model dependecy
    /// - Parameters:
    ///   - productsScreenViewModel: Injecting dependency of ProductsViewModelProtocol type to make it loosely coupled with view model class and expose only those methods which are relevant for this view.
    init(productDetailsScreenViewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: productDetailsScreenViewModel)
        
        // Sets page indicators for tab view pagination.
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.navigationBarColor)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(.navigationBarColor).withAlphaComponent(0.3)
    }
    
    var body: some View {
        switch viewModel.state {
        case .startLoading:
            LoadingView(screenTitle: Constants.ScreenTitles.productDetails)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: BackButtonView())
                .onAppear(perform: {
                    viewModel.fetchProductDetails()
                })
        case .errorLoading(let error):
            ErrorView(error: error, screenTitle: Constants.ScreenTitles.productDetails)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: BackButtonView())
        case .dataLoaded:
            ZStack {
                BackgroundView()
                VStack {
                    VStack(alignment: .leading, content: {
                        Text(viewModel.productDetails.title ?? "")
                            .padding()
                            .font(.system(size: 25))
                            .bold()
                        
                        TabView {
                            ForEach(viewModel.productDetails.images ?? [], id: \.self) { item in
                                AsyncImage(url: URL(string: item), content: { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                }, placeholder: {
                                    ProgressView()
                                })
                            }
                        } //: Tabview
                        .tabViewStyle(PageTabViewStyle())
                        .frame(height: UIScreen.main.bounds.height/3)
                        .shadow(color: .black.opacity(0.6), radius: 20)
                        
                        HStack() {
                            HStack(spacing: -10) {
                                HStack(alignment: .bottom) {
                                    Text("$\(viewModel.productDetails.finalPrice ?? 0.0, specifier: "%.2f")")
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.red)
                                    
                                    Text("$\(viewModel.productDetails.price ?? 0.0, specifier: "%.2f")")
                                        .font(.system(size: 13))
                                        .fontWeight(.light)
                                        .strikethrough()
                                }
                                Spacer()
                                Text(String(format: Constants.Labels.stock, viewModel.productDetails.stock ?? 0))
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                            }
                        } //: HStack
                        .padding()
                        
                        VStack(alignment: .leading) {
                            Text(Constants.Labels.description)
                                .foregroundStyle(.titleText)
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .padding()
                                .padding(.top, -15)
                            
                            Text(viewModel.productDetails.description ?? "")
                                .foregroundStyle(.darkGray)
                                .font(.system(size: 13))
                                .fontWeight(.light)
                                .padding()
                                .padding(.top, -30)
                        }
                    }) //: VStack
                    Spacer()
                }
                .navigationTitle(Constants.ScreenTitles.productDetails)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: BackButtonView())
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(
                    Color.navigationBarColor,
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            }
        }
        
        
    }
}

#Preview {
    ProductDetailScreen(productDetailsScreenViewModel: ProductDetailsViewModel(fetchProductDetailsUseCase: FetchProductDetailsUseCase(repository: ProductDetailsRepository()), productId: 1))
}
