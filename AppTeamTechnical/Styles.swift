//
//  Styles.swift
//  AppTeamTechnical
//
//  Created by alfeng on 9/13/24.
//

import SwiftUI

struct NavBarTitleColorModifier: ViewModifier {
    init(titleColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        UINavigationBar.appearance().standardAppearance = appearance
        appearance.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
    }
    func body(content: Content) -> some View {
        content
    }
}

struct SearchBarStyleModifier: ViewModifier {
    init() {
        // Customize the UISearchBar appearance globally
        let searchBarAppearance = UISearchBar.appearance()
        searchBarAppearance.searchTextField.textColor = UIColor.white  // Set text color to white
        searchBarAppearance.searchTextField.backgroundColor = UIColor.darkGray // Optional: Set background color of search bar
    }

    func body(content: Content) -> some View {
        content
    }
}

struct AddCartButtonStyle: ButtonStyle {
    var displayColor: Color = Color(.blue)
    var pressedColor: Color = Color(red: 9/255, green: 99/255, blue: 191/255)

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .padding(.horizontal, 50)
            .padding(.vertical, 10)
            .background(configuration.isPressed ? pressedColor : displayColor)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 25))
            .scaleEffect(configuration.isPressed ? 1.05 : 1.0)
            .animation(.spring(duration: 1, bounce: 0.7), value: configuration.isPressed)
    }
}

struct TotalAmountStyle: ButtonStyle {
    var displayColor: Color = Color(red: 211/255, green: 211/255, blue: 211/255)
    var pressedColor: Color = Color(red: 28/255, green: 28/255, blue: 30/255)

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .padding(10)
            .background(configuration.isPressed ? pressedColor : displayColor)
            .clipShape(.rect(cornerRadius: 6))
            .scaleEffect(configuration.isPressed ? 1.05 : 1.0)
            .animation(.spring(duration: 1, bounce: 0.7), value: configuration.isPressed)
    }
}

struct AddLikeButtonStyle: ButtonStyle {
    var isDark: Bool
    
    var displayColor: Color {
        return isDark ? Color(red: 58/255, green: 58/255, blue: 60/255) : Color(.lightGray)
    }
    var pressedColor: Color {
        return isDark ? Color(red: 44/255, green: 44/255, blue: 45/255) : Color(.gray)
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(configuration.isPressed ? pressedColor : displayColor)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .animation(.spring(duration: 1, bounce: 0.7), value: configuration.isPressed)
    }
}

struct pressProductStyle: ButtonStyle {
    var displayColor: Color = Color(red: 58/255, green: 58/255, blue: 60/255)
    var pressedColor: Color = Color(red: 44/255, green: 44/255, blue: 45/255)

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? pressedColor : displayColor)
    }
}

struct CartBadgeModifier: ViewModifier {
    var itemCount: Int

    func body(content: Content) -> some View {
        ZStack {
            content
            
            if itemCount > 0 {
                Text("\(itemCount)")
                    .font(.caption2)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.orange)
                    .clipShape(Circle())
//                    .offset(x: 10, y: -10)  // Position the badge in the top-right corner
            }
        }
    }
}

struct AdaptiveTextModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .foregroundColor(colorScheme == .dark ? .white : .black)
    }
}

struct AdaptiveBackgroundModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .background((colorScheme == .dark) ? .darkBackground : .lightBackground)
    }
}

struct Styles: View {
    @State var itemCount = 2
    var body: some View {
            VStack {
                Button("Add Item") {
                    itemCount += 1
                }
                Text("Cart Items: \(itemCount)")
            }
        TabView{
            Styles()
                .tabItem {
                    ZStack {
                        Label("", systemImage: "cart")
                    }
                }
        }
        NavigationStack {
            ZStack {
                Color(red: 28/255, green: 28/255, blue: 30/255)
                HStack{
                    Button {
                    } label: {
                        Text("Add to Cart")
                    }
                    .buttonStyle(AddCartButtonStyle())
                    Button{
                    } label: {
                        Image(systemName: "heart.fill")
                    }
                    .buttonStyle(AddLikeButtonStyle(isDark: false))
                }
                
            }
            .navigationTitle("Title Color")
            .navBarColor(.white)
            .ignoresSafeArea()
        }
    }
}

extension View {
    func navBarColor(_ color: UIColor) -> some View {
        self.modifier(NavBarTitleColorModifier(titleColor: color))
    }
    func searchBarCustom() -> some View {
        self.modifier(SearchBarStyleModifier())
    }
    func cartBadge(itemCount: Int) -> some View {
        self.modifier(CartBadgeModifier(itemCount: itemCount))
    }
    func adaptiveForeground() -> some View {
        self.modifier(AdaptiveTextModifier())
    }
    func adaptiveBackground() -> some View {
        self.modifier(AdaptiveBackgroundModifier())
    }
}

#Preview {
    Styles()
}
