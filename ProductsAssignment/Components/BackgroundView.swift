//
//  ImageBackgroundView.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 25/05/24.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(colors: [Color.orange.opacity(0.4), Color.white], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
