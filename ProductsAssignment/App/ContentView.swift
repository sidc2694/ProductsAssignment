//
//  ContentView.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 22/05/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var navigationManager = NavigationManager(path: NavigationPath())
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            navigationManager.build(page: .productList)
                .navigationDestination(for: Page.self) { page in
                    navigationManager.build(page: page)
                }
        }
        .environmentObject(navigationManager)
    }
}

#Preview {
    ContentView()
}
