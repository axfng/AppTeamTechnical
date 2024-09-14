//
//  ProductView.swift
//  AppTeamTechnical
//
//  Created by alfeng on 9/13/24.
//
//

import SwiftUI

struct ProductView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var viewModel: ProductViewModel
    
    @Binding var cart: [Product]
    @Binding var likedItems: [Product]
    @Binding var itemCount: Int
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(viewModel.filteredProducts, id: \.id) {item in
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
                                        heartFill(isLiked: item.isLiked)
                                    }
                                    .buttonStyle(AddLikeButtonStyle(isDark: (colorScheme == .dark)))
                                    Spacer()

                                }
                            }
                            .adaptiveForeground()
                            .frame(alignment: .leading)

                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .searchable(text: $viewModel.searchText, prompt: "What are you looking for?")
                .searchBarCustom()
                .ignoresSafeArea()
            }
            .adaptiveBackground()
            .navBarColor(.white)
        }
        .task {
            await viewModel.loadData()
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
        
    private func heartFill(isLiked: Bool) -> Image {
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
    
    return ProductView(viewModel: mockViewModel, cart: .constant([]), likedItems: .constant([]), itemCount: $itemCount)
}

//struct Products: Codable {
//    var products: [Product]
//}
//
//struct Product: Codable, Identifiable {
//    var id: Int
//    var title: String
//    var description: String
//    var category: String
//    var price: Double
//    var images: [String]
//    var tags: [String]
//    var isLiked: Bool = false
//    
//    enum CodingKeys: String, CodingKey {
//            case id, title, description, category, price, images, tags
//        }
//}
//
//struct ProductView: View {
//    @Environment(\.colorScheme) var colorScheme
//    
//    @Binding var cart: [Product]
//    @Binding var likedItems: [Product]
//    @Binding var itemCount: Int
//    
//    @State private var products = [Product]()
//    @State private var searchText = ""
//    
//    var filteredProducts: [Product] {
//        if searchText.isEmpty{
//            products
//        } else {
//            products.filter { products in
//                products.tags.contains { tag in
//                    tag.localizedStandardContains(searchText)
//                }
//            }
//        }
//    }
//    
//    var body: some View {
//        NavigationStack{
//            ScrollView {
//                ForEach(filteredProducts, id: \.id) {item in
//                    NavigationLink {
//                        ItemView(product: item)
//                    } label: {
//                        HStack {
//                            AsyncImage(url: URL(string: item.images[0])) { phase in
//                                if let image = phase.image {
//                                    image
//                                        .resizable()
//                                        .scaledToFit()
//                                } else if phase.error != nil {
//                                    Text("There was an error loading the image")
//                                } else {
//                                    ProgressView()
//                                }
//                            }
//                            .frame(width: 140, height: 140)
//                            VStack(alignment: .leading) {
//                                Text(item.title)
//                                    .lineLimit(1)
//                                Text(item.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                                    .bold()
//                                Text(item.tags[0].capitalized)
//                                    .font(.subheadline)
//                                HStack {
//                                    Button{
//                                        addToCart(product: item)
//                                    } label: {
//                                        Text("Add to Cart")
//                                    }
//                                    .buttonStyle(AddCartButtonStyle())
//                                    Spacer()
//                                    Button{
//                                        addToLikedItems(product: item)
//                                    } label: {
//                                        heartFill(isLiked: item.isLiked)
//                                    }
//                                    .buttonStyle(AddLikeButtonStyle(isDark: (colorScheme == .dark)))
//                                    Spacer()
//                                    
//                                }
//                            }
//                            .adaptiveForeground()
//                            .frame(alignment: .leading)
//                            
//                            Spacer()
//                        }
//                    }
//                    .frame(maxWidth: .infinity)
//                }
//                .frame(maxWidth: .infinity)
//                .searchable(text: $searchText, prompt: "What are you looking for?")
//                .searchBarCustom()
//                .ignoresSafeArea()
//            }
//            .adaptiveBackground()
//            .navBarColor(.white)
//        }
//        .task {
//            await loadData()
//        }
//        
//    }
//    
//    func loadData() async {
//        guard let url = URL(string: "https://dummyjson.com/products") else{
//            print("Invalid URL")
//            return
//        }
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            if let decodedResponse = try? JSONDecoder().decode(Products.self, from: data) {
//                products = decodedResponse.products
//            }
//        } catch {
//            print("Invalid data")
//        }
//    }
//    
//    private func addToCart(product: Product) {
//        cart.append(product)
//        itemCount += 1
//    }
//    private func addToLikedItems(product: Product) {
//        // Find the index of the product in the products array
//        if let index = products.firstIndex(where: { $0.id == product.id }) {
//            products[index].isLiked.toggle()  // Toggle the isLiked property
//
//            // Update likedItems array
//            if products[index].isLiked {
//                likedItems.append(products[index])
//            } else {
//                likedItems.removeAll(where: { $0.id == product.id })
//            }
//        }
//    }
//    private func heartFill(isLiked: Bool) -> Image {
//        if isLiked {
//            return Image(systemName: "heart.fill")
//        } else {
//            return Image(systemName: "heart")
//        }
//    }
//}
//
//#Preview {
//    @State var itemCount: Int = 0
//    return ProductView(cart: .constant([]), likedItems: .constant([]), itemCount: $itemCount)
//}
