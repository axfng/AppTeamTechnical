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

struct AddCartButtonStyle: ButtonStyle {
    var displayColor: Color = Color(.blue)
    var pressedColor: Color = Color(red: 9/255, green: 99/255, blue: 191/255)

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .padding(.horizontal, 45)
            .padding(.vertical, 10)
            .background(configuration.isPressed ? pressedColor : displayColor)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 25))
    }
}

struct AddLikeButtonStyle: ButtonStyle {
    var displayColor: Color = Color(red: 58/255, green: 58/255, blue: 60/255)
    var pressedColor: Color = Color(red: 44/255, green: 44/255, blue: 45/255)

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(configuration.isPressed ? pressedColor : displayColor)
            .foregroundStyle(.white)
            .clipShape(.circle)
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

struct waterMark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding()
                .background(.black)
        }
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
                            .waterMarker(with: "hi")
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
                    .buttonStyle(AddLikeButtonStyle())
                }
                
            }
            .navigationTitle("Title Color")
            .navBarTitleColor(.white)
            .ignoresSafeArea()
        }
    }
}

extension View {
    func navBarTitleColor(_ color: UIColor) -> some View {
        self.modifier(NavBarTitleColorModifier(titleColor: color))
    }
    func cartBadge(itemCount: Int) -> some View {
            self.modifier(CartBadgeModifier(itemCount: itemCount))
    }
    func waterMarker(with text: String) -> some View {
        modifier(waterMark(text: text))
    }
}

#Preview {
    Styles()
}
