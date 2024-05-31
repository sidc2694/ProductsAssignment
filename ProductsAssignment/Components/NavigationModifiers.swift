//
//  NavigationModifiers.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 26/05/24.
//

import SwiftUI

struct NavigationModifiers: ViewModifier {
    
    let title: String
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(
                Color.navigationBarColor,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}
