//
//  ContentView.swift
//  AppTeamTechnical
//
//  Created by alfeng on 9/12/24.
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

struct ContentView: View {
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
            List(filteredProducts, id: \.id) {item in
                Text(item.title)
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
                .frame(width: 200, height: 200)
            }
            .task {
                await loadData()
            }
            .searchable(text: $searchText, prompt: "What are you looking for?")
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
    ContentView()
}
