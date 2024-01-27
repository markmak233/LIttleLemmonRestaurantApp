//
//  FoodItemView.swift
//  Restaurant
//
//  Created by marco mai on 2024-01-23.
//

import SwiftUI

struct FoodItem: View {
    
    let dish:Dish
    
    var body: some View {
        HStack {
            VStack {
//                tittle
                Text(dish.title ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer(minLength: 1)
//                description
                Text(dish.descriptionDish ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.color1)
                    .lineLimit(2)
                Spacer(minLength: 1)
//                price
                Text("$" + (dish.price ?? ""))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.color1)
                    .monospaced()
            }
//            image
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: 90, maxHeight: 90)
            .clipShape(Rectangle())
        }
        .padding(.vertical)
        .frame(maxHeight: 130)
    }
}

struct FoodItem_Previews: PreviewProvider {
    static var previews: some View {
        FoodItem(dish: PersistenceController.oneDish())
    }
    
}
