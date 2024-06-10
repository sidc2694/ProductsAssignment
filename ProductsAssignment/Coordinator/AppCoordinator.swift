//
//  AppCoordinator.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 10/06/24.
//

import Foundation
import SwiftUI

final class AppCoordinator: ObservableObject {
    @Published var path: NavigationPath

    init(path: NavigationPath) {
        self.path = path
    }

    @ViewBuilder
    func view() -> some View {
        ContentView()
    }
}
