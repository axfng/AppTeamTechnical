//
//  ContentView.swift
//  AppTeamTechnical
//
//  Created by alfeng on 9/12/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView{
            ProductView()
                .tabItem {
                    Label("Products", systemImage: "")
                }
            MyItemView()
                .tabItem {
                    Label("My Items", systemImage: "")
                }
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "")
                }
        }
    }
}

#Preview {
    ContentView()
}
