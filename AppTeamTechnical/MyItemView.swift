//
//  MyItemView.swift
//  AppTeamTechnical
//
//  Created by alfeng on 9/13/24.
//

import SwiftUI

struct MyItemView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var viewModel: ProductViewModel
    
    @Binding var cart: [Product]
    @Binding var likedItems: [Product]
    @Binding var itemCount: Int
    
    let mockupItem = Product(
            id: 1,
            title: "Essence Mascara Labejhsd",
            description: "This is a description of the sample product.",
            category: "Sample Category with a very long title",
            price: 9.99,
            images: ["https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png"],
            tags: ["SampleTag"],
            isLiked: true
        )
    
    var body: some View {
        NavigationStack {
            ScrollView{
                ForEach(likedItems, id: \.id) { item in
                    NavigationLink {
                        
                    } label: {
                        HStack{
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
                            .frame(width: 140, height: 140)
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .lineLimit(1)
                                Text(item.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .bold()
                                Text(item.tags[0].capitalized)
                                    .font(.subheadline)
                                HStack {
                                    Button{
                                        addToCart(product: item)
                                    } label: {
                                        Text("Add to Cart")
                                    }
                                    .buttonStyle(AddCartButtonStyle())
                                    Spacer()
                                    Button{
//                                        addToLikedItems(product: item)
                                    } label: {
                                        Image(systemName: "heart")
                                        fillHeart(isLiked: item.isLiked)
                                    }
                                    .buttonStyle(AddLikeButtonStyle(isDark: (colorScheme == .dark)))
                                    Spacer()

                                }
                            }
                            .adaptiveForeground()
                            .frame(alignment: .leading)
                        }
                    }
                }
            }
            .navigationTitle("My Items")
            .adaptiveForeground()
        }
    }
    func addToCart(product: Product) {
        cart.append(product)
        itemCount += 1
    }
    
    func addToLikedItems(product: Product) {
        if let index = viewModel.products.firstIndex(where: { $0.id == product.id }) {
            viewModel.products[index].isLiked.toggle()  // Toggle the isLiked property locally
            
            if viewModel.products[index].isLiked {
                likedItems.append(viewModel.products[index])
            } else {
                likedItems.removeAll { $0.id == product.id }
            }
        }
    }
        
    private func fillHeart(isLiked: Bool) -> Image {
        if isLiked {
            return Image(systemName: "heart.fill")
        } else {
            return Image(systemName: "heart")
        }
    }
}

#Preview {
    let mockViewModel = ProductViewModel()
    @State var itemCount: Int = 0
    
    return MyItemView(viewModel: mockViewModel, cart: .constant([]), likedItems: .constant([]), itemCount: $itemCount)
}
