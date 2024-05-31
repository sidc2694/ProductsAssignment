//
//  ErrorView.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 26/05/24.
//

import SwiftUI

struct ErrorView: View {
    var error: String
    var screenTitle: String = Constants.ScreenTitles.products
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(alignment: .center) {
                Text(error)
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
        .modifier(NavigationModifiers(title: screenTitle))
    }
}

#Preview {
    ErrorView(error: APIErrors.noInternet.failureReason!)
}
