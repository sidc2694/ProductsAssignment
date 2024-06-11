//
//  CoordinatorProtocol.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 11/06/24.
//

import Foundation
import SwiftUI

protocol CoordinatorProtocol {
    associatedtype ViewType: View
    
    var navigationPath: NavigationPath { get }
    
    func build() -> ViewType
    func push<V>(_ value: V) where V : Hashable
}
