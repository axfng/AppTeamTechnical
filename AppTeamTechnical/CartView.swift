//
//  CartView.swift
//  AppTeamTechnical
//
//  Created by alfeng on 9/13/24.
//

import SwiftUI

struct CartView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var cart: [Product]
    @Binding var itemCount: Int
    
    let item = Product(
            id: 1,
            title: "Essence Mascara Labejhsd",
            description: "This is a description of the sample product.",
            category: "Sample Category with a very long title",
            price: 9.99,
            images: ["https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png"],
            tags: ["SampleTag"],
            isLiked: true
        )
    
    var body: some View {
        NavigationStack {
            VStack{
                if itemCount == 0 {
                    HStack {
                        Text("Your cart is empty!")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .adaptiveForeground()
                    }
                } else {
                    ScrollView {
                        ForEach(cart, id:\.id) { item in
                            NavigationLink{
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
                                    .frame(width: 40, height: 40)
                                    Text(item.title)
                                        .lineLimit(1)
                                    Spacer()
                                    Text(item.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                        .bold()
                                        .padding(.leading, 60)
                                }
                                .adaptiveBackground()
                                .adaptiveForeground()
                                .buttonStyle(pressProductStyle())
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 10)
                        }
                    }
                }
                Spacer()
                //                    Button {
                //
                //                    } label: {
                //                        VStack {
                //                            HStack {
                //                                Text(getTotalCost(), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                //                                    .bold()
                //                                Text("total")
                //                                    .bold()
                //                                Spacer()
                //                                Image(systemName: "chevron.down")
                //                            }
                //                            Text("\(getTotalItems()) items")
                //                                .font(.subheadline)
                //                        }
                //                        .padding(10)
                //                        .background(.gray)
                //                        .adaptiveForeground()
                //                        .clipShape(.rect(cornerRadius: 6))
                //
                //                    }
                //                    .padding()
                //                    }
                VStack {
                    Button {
                        
                    } label: {
                        Text("Check Out")
                            .padding(.horizontal, 80)
                    }
                    .buttonStyle(AddCartButtonStyle())
                }
            }
            .adaptiveBackground()
            .navigationTitle("Cart (\(itemCount))")
            .navBarColor(colorScheme == .dark ? .white : .black)
        }
    }
    
    func getTotalCost() -> Double {
        var total: Double = 0.0
        for product in cart {
            total += product.price
        }
        return total*1.07
    }
    func getTotalItems() -> Int {
        var total: Int = 0
        for _ in cart {
            total += 1
        }
        return total
    }
}

#Preview {
    @State var itemCount: Int = 0
    return CartView(cart: .constant([]), itemCount: $itemCount)
}
