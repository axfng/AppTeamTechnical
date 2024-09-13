//
//  ContentView.swift
//  AppTeamTechnical
//
//  Created by alfeng on 9/12/24.
//

import SwiftUI

struct Response: Codable {
    var products: [Result]
}

struct Result: Codable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var category: String
    var price: Double
    var images: [String]
}

struct ContentView: View {
    @State private var products = [Result]()
    
    var body: some View {
        NavigationStack{
            List(products, id: \.id) {item in
                Text(item.title)
            }
            .task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://dummyjson.com/products") else{
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
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
