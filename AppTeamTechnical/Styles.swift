//
//  Styles.swift
//  AppTeamTechnical
//
//  Created by alfeng on 9/13/24.
//

import SwiftUI

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
    }
}

struct AddFavoriteButtonStyle: ButtonStyle {
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

struct Styles: View {
    var body: some View {
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
                    Image(systemName: "heart")
                }
                .buttonStyle(AddFavoriteButtonStyle())
            }
        }
        .ignoresSafeArea()
    }
}

extension View {

}

#Preview {
    Styles()
}
