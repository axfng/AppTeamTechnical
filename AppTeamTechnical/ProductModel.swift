//
//  ProductModel.swift
//  AppTeamTechnical
//
//  Created by alfeng on 9/14/24.
//

import Foundation

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
    var isLiked: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, category, price, images, tags
    }
}
