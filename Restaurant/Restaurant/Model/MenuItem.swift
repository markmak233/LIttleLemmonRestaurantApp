//
//  MenuItem.swift
//  Restaurant
//
//  Created by marco mai on 2024-01-23.
//

import Foundation

struct JSONMenu: Codable{
    let menu:[MenuItem]
}

struct MenuItem: Codable, Identifiable{
    var id = UUID()
    let title: String
    let price: String
    let description: String
    let image: String
    let cat: String
    
    enum CodingKeys: String, CodingKey{
        case title = "title"
        case description = "description"
        case price = "price"
        case image = "image"
        case cat = "category"
    }
}
