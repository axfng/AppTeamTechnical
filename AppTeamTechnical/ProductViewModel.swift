//
//  ProductViewModel.swift
//  AppTeamTechnical
//
//  Created by alfeng on 9/14/24.
//

import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var searchText: String = ""
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return products
        } else {
            return products.filter { product in
                product.tags.contains { tag in
                    tag.localizedStandardContains(searchText)
                }
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Products.self, from: data) {
                DispatchQueue.main.async {
                    self.products = decodedResponse.products
                }
            }
        } catch {
            print("Invalid data")
        }
    }
}

