//
//  Home.swift
//  Restaurant
//
//  Created by marco mai on 2024-01-23.
//

import SwiftUI

struct Home: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView{
            NavigationStack{
                VStack{
                    Menu()
                }
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    Home().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
