//
//  ProductsAssignmentApp.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 21/05/24.
//

import SwiftUI

@main
struct ProductsAssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            let _ = NetworkCheckManager.shared
            ContentView()
        }
    }
}
