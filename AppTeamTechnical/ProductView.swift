//
//  ProductView.swift
//  AppTeamTechnical
//
//  Created by alfeng on 9/13/24.
//
//

import SwiftUI

struct Products: Codable {
    var products: [Product]
}

struct Product: Codable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var category: String
    var price: Double
    var images: [String]
    var tags: [String]
}

struct ProductView: View {
    @Binding var cart: [Product]
    @Binding var likedItems: [Product]
    @Binding var itemCount: Int
    
    @State private var products = [Product]()
    @State private var searchText = ""
    
    var filteredProducts: [Product] {
        if searchText.isEmpty{
            products
        } else {
            products.filter { products in
                products.tags.contains { tag in
                    tag.localizedStandardContains(searchText)
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                ForEach(filteredProducts, id: \.id) {item in
                    NavigationLink {
                        ItemView(product: item)
                    } label: {
                        HStack {
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
                                        addToLikedItems(product: item)
                                    } label: {
                                        Image(systemName: "heart")
                                    }
                                    .buttonStyle(AddLikeButtonStyle())
                                    Spacer()
                                    
                                }
                            }
                            .foregroundStyle(.white)
                            .frame(alignment: .leading)
                            
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .searchable(text: $searchText, prompt: "What are you looking for?")
                .ignoresSafeArea()
            }
            .background(.darkBackground)
            .navBarTitleColor(.white)
        }
        .task {
            await loadData()
        }
        
    }
    
    func loadData() async {
        guard let url = URL(string: "https://dummyjson.com/products") else{
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Products.self, from: data) {
                products = decodedResponse.products
            }
        } catch {
            print("Invalid data")
        }
    }
    
    private func addToCart(product: Product) {
        cart.append(product)
        itemCount += 1
    }
    private func addToLikedItems(product: Product) {
        likedItems.append(product)
    }
}

#Preview {
    @State var itemCount: Int = 0
    return ProductView(cart: .constant([]), likedItems: .constant([]), itemCount: $itemCount)
}
