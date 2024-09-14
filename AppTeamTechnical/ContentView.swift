//
//  ContentView.swift
//  AppTeamTechnical
//
//  Created by alfeng on 9/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var cart: [Product] = []
    @State private var likedItems: [Product] = []
    @State private var itemCount: Int = 0
    
    var body: some View {
        ZStack{
            TabView{
                ProductView(cart: $cart, likedItems: $likedItems, itemCount: $itemCount)
                    .tabItem {
                        Label("Products", systemImage: "bag")
                    }
                MyItemView(likedItems: $likedItems)
                    .tabItem {
                        Label("My Items", systemImage: "heart")
                    }
                CartView(cart: $cart)
                    .tabItem {
                        Label("Cart", systemImage: "cart")
                            .cartBadge(itemCount: itemCount)
                    }
            }
        }
        .background(.darkBackground)
    }
}

#Preview {
    ContentView()
}
