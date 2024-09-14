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
                            .frame(width: 160, height: 160)
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .lineLimit(1)
                                Text(item.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                Text(item.tags[0])
                                HStack {
                                    Spacer()
                                    Button{
                                        
                                    } label: {
                                        Text("Add to Cart")
                                    }
                                    .buttonStyle(AddCartButtonStyle())
                                    Spacer()
                                    Button{
                                        
                                    } label: {
                                        Image(systemName: "heart")
                                            .background(.gray)
                                    }
                                    Spacer()
                                    
                                }
                            }
                            .foregroundStyle(.black)
                            .frame(alignment: .leading)
                            
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .searchable(text: $searchText, prompt: "What are you looking for?")
            }
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
}

#Preview {
    ProductView()
}
