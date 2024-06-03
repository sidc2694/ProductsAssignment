//
//  CoordinatorProtocol.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 03/06/24.
//

import Foundation

protocol CoordinatorProtocol {
    func push(_ page: Page)
    func pop()
    func popToRoot()
}
