//
//  ContentView.swift
//  AppTeamTechnical
//
//  Created by alfeng on 9/12/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = ProductViewModel()
    
    @State private var cart: [Product] = []
    @State private var likedItems: [Product] = []
    @State private var itemCount: Int = 0
    
    var body: some View {
        TabView{
            Group {
                ProductView(viewModel: viewModel, cart: $cart, likedItems: $likedItems, itemCount: $itemCount)
                    .tabItem {
                        Label("Products", systemImage: "bag")
                    }
                MyItemView(viewModel: viewModel, cart: $cart, likedItems: $likedItems, itemCount: $itemCount)
                    .tabItem {
                        Label("My Items", systemImage: "heart")
                    }
                CartView(cart: $cart, itemCount: $itemCount)
                    .tabItem {
                        Label("Cart", systemImage: "cart")
                            .cartBadge(itemCount: itemCount)
                    }
            }
            .toolbarBackground(Color("ItemBackground"), for: .tabBar)
            .toolbarBackground((colorScheme == .dark) ? .darkBackground : .lightBackground, for: .tabBar)
            .toolbarColorScheme((colorScheme == .dark) ? .dark : .light, for: .tabBar)
        }
        .adaptiveBackground()
    }
}

#Preview {
    ContentView()
}
