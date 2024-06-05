//
//  BackButtonView.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 23/05/24.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            HStack(spacing: 0) {
                Image(systemName: Constants.Images.backImage)
                    .font(.title2)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            } //: HStack
        })
    }
}

#Preview {
    BackButtonView()
}
