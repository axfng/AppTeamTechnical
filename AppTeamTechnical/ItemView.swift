//
//  ItemView.swift
//  AppTeamTechnical
//
//  Created by alfeng on 9/13/24.
//

import SwiftUI

struct ItemView: View {
    let product: Product
    
    var body: some View {
        Text("Hello, World!")
    }
    
}

#Preview {
    let mockProduct = Product(
            id: 1,
            title: "Sample Product",
            description: "This is a description of the sample product.",
            category: "Sample Category",
            price: 19.99,
            images: ["https://dummyimage.com/200x200"],
            tags: ["SampleTag"]
        )
    return ItemView(product: mockProduct)
}
