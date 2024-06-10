//
//  ProductsAssignmentApp.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 21/05/24.
//

import SwiftUI
import Kingfisher

@main
struct ProductsAssignmentApp: App {
    private let imageDownloaderAuthenticationChallenge = ImageDownloaderAuthenticationChallenge()
    @StateObject private var coordinator = AppCoordinator(path: NavigationPath())
    
    init() {
        ImageDownloader.default.authenticationChallengeResponder = imageDownloaderAuthenticationChallenge
    }

    var body: some Scene {
        WindowGroup {
            let _ = NetworkCheckManager.shared
            NavigationStack(path: $coordinator.path) {
                coordinator.view()
                    .navigationDestination(
                        for: ProductsCoordinator.self
                    ) { coordinator in
                        coordinator.view()
                    }
            }
            .environmentObject(coordinator)
        }
    }
}
