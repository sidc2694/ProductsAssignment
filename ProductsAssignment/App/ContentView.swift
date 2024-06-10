//
//  ContentView.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 22/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        ProductsCoordinator(
            page: .productList,
            navigationPath: $appCoordinator.path
        ).view()
    }
}

#Preview {
    ContentView()
}
