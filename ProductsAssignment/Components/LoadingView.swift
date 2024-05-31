//
//  LoadingView.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 26/05/24.
//

import SwiftUI

struct LoadingView: View {
    var screenTitle: String = Constants.ScreenTitles.products
    var body: some View {
        ZStack {
            BackgroundView()
            ProgressView()
                .scaleEffect(2)
        }
        .modifier(NavigationModifiers(title: screenTitle))
    }
}

#Preview {
    LoadingView()
}
