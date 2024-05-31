//
//  ContentView.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 22/05/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = Coordinator(path: NavigationPath())
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .productList)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    ContentView()
}
