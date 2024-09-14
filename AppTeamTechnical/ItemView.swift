//
//  ItemView.swift
//  AppTeamTechnical
//
//  Created by alfeng on 9/13/24.
//

import SwiftUI

struct ItemView: View {
    let product: Product
    
    let item = Product(
            id: 1,
            title: "Essence Mascara Labejhsd",
            description: "This is a description of the sample product.",
            category: "Sample Category with a very long title",
            price: 9.99,
            images: ["https://cdn.dummyjson.com/products/images/fragrances/Gucci%20Bloom%20Eau%20de/1.png"],
            tags: ["SampleTag"],
            isLiked: true
        )
    
    var body: some View {
        ScrollView{
            VStack{
                HStack {
                    
                }
                AsyncImage(url: URL(string: item.images[0])) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Text("There was an error loading the image")
                    } else {
                        ProgressView()
                    }
                }
                HStack {
                    Text(item.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .font(.title.bold())
                        .adaptiveForeground()
                    Spacer()
                }
                HStack {
                    Button {
                        
                    } label: {
                        
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal){
                HStack {
                    Text(item.title)
                }
            }
        }
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
            tags: ["SampleTag"],
            isLiked: true
        )
    return ItemView(product: mockProduct)
}
