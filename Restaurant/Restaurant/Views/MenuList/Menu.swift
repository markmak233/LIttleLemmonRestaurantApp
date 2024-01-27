//
//  Menu.swift
//  Restaurant
//
//  Created by marco mai on 2024-01-23.
//

import SwiftUI
import CoreData

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var startersIsEnabled = true
    @State var mainsIsEnabled = true
    @State var dessertsIsEnabled = true
    @State var drinksIsEnabled = true
    
    @State var searchText = ""
    
    @State var loaded = false
    
    @State var isKeyboardVisible = false
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        
        VStack{
            VStack{
                Spacer(minLength: 1)
                ZStack{
                    Image("Logo")
                    HStack{
                        Spacer()
                        NavigationLink(destination: ProfileView()){
                            Image("Profile")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 50)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }

                    }
                }.frame(maxHeight: 50)
                VStack{
                    Header()
//                    seach box
                    TextField("Search", text: $searchText).textFieldStyle(.roundedBorder).padding(.horizontal)
                    Text("Order Your Delivery").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.color3)
                    ScrollView(.horizontal, showsIndicators: false) {
//                        button group
                        HStack(spacing: 20) {
                            Toggle("Starters", isOn: $startersIsEnabled)
                            Toggle("Mains", isOn: $mainsIsEnabled)
                            Toggle("Desserts", isOn: $dessertsIsEnabled)
                            Toggle("Drinks", isOn: $drinksIsEnabled)
                        }
                        .toggleStyle(ButtonToggleStyle())
                        .padding()
                    }
                }
            }.background(.color1).frame(maxHeight: 400 )
            
            

//fetch dish list
            FetchedData(predicate: buildPredicate(),
                        sortDescriptors: buildSortDescriptors()){
                (dishes: [Dish]) in
                List(dishes) { dish in
                    NavigationLink(destination: DetailItem(dish: dish)) {
                        FoodItem(dish: dish)
                    }
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            if !loaded {
                MenuList.getMenuData(viewContext: viewContext)
                loaded = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
            withAnimation {
                self.isKeyboardVisible = true
            }
            
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
            withAnimation {
                self.isKeyboardVisible = false
            }
        }
    }

        
    
//    sort descriptor base on tittle
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                  ascending: true,
                                  selector:
                                    #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSCompoundPredicate {
        let search = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        let starters = !startersIsEnabled ? NSPredicate(format: "category != %@", "starters") : NSPredicate(value: true)
        let mains = !mainsIsEnabled ? NSPredicate(format: "category != %@", "mains") : NSPredicate(value: true)
        let desserts = !dessertsIsEnabled ? NSPredicate(format: "category != %@", "desserts") : NSPredicate(value: true)
        let drinks = !drinksIsEnabled ? NSPredicate(format: "category != %@", "drinks") : NSPredicate(value: true)

        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [search, starters, mains, desserts, drinks])
        return compoundPredicate
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
