//
//  ProductsView.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 22/05/24.
//

import SwiftUI
import Kingfisher

struct ProductCellView: View {

    private let productCell: ProductCell

    init(productCell: ProductCell) {
        self.productCell = productCell
    }

    var body: some View {
        HStack(spacing: 15) {
            KFImage(productCell.thumbnailUrl)
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .background(Color.black.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.3), radius: 10)

            VStack(alignment: .leading, spacing: 5) {
                Text(productCell.title ?? "")
                    .foregroundStyle(.titleText)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
                HStack(alignment: .bottom) {
                    Text("$\(productCell.finalPrice ?? 0.0, specifier: "%.2f")")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundStyle(.red)

                    Text("$\(productCell.price ?? 0.0, specifier: "%.2f")")
                        .foregroundStyle(.darkGrayApp)
                        .font(.system(size: 13))
                        .fontWeight(.light)
                        .strikethrough()
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Actual price is \(productCell.price ?? 0.0, specifier: "%.2f") and Discounted price is \(productCell.finalPrice ?? 0.0, specifier: "%.2f")")
                Spacer()
            } //: VStack
        } //: HStack
        .frame(height: 150)
        .listRowInsets(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
        .contentShape(Rectangle())
    }
}

#Preview {
    List {
        ProductCellView(productCell: ProductCell(thumbnailUrl: URL(string: "https://cdn.dummyjson.com/product-images/100/thumbnail.jpg"), title: "Crystal chandelier maria theresa for 12 light", price: 20, finalPrice: 10))
    }
}
