//
//  ItemCheaterView.swift
//  StrayCompanion
//
//  Created by Luis Hankel on 02/03/2020.
//  Copyright © 2020 Luis Hankel. All rights reserved.
//

import SwiftUI

struct ItemCheaterView: View {
    @EnvironmentObject var model: CompanionModel
    
    let items = [
        Item(name: "Apple", amount: 1),
        Item(name: "Berry", amount: 1),
        Item(name: "CookedMeat", amount: 1),
        Item(name: "FirstAidKit", amount: 1),
        Item(name: "Iron", amount: 1),
        Item(name: "IronAxe", amount: 1),
        Item(name: "IronPickaxe", amount: 1),
        Item(name: "Knife", amount: 1),
        Item(name: "Machete", amount: 1),
        Item(name: "Meat", amount: 1),
        Item(name: "Stone", amount: 1),
        Item(name: "StoneAxe", amount: 1),
        Item(name: "StonePickaxe", amount: 1),
        Item(name: "WaterBottle", amount: 1),
        Item(name: "Wood", amount: 1),
        Item(name: "Wool", amount: 1),
    ]
    
    var body: some View {
        Grid(items: items) { item in
            Button(action: { self.model.addItem(item: item) }) {
                VStack {
                    self.getIconImage(icon: item.icon)
                        .scaledToFit()
                        .frame(height: 100)
                    Text(item.displayName)
                    HStack {
                        Image(systemName: "plus")
                        Text("Add")
                    }.foregroundColor(.blue)
                }
            }.buttonStyle(PlainButtonStyle())
        }.padding()
    }
}

extension ItemCheaterView {
    func getIconImage(icon: String?) -> some View {
        if let icon = icon {
            return Image(icon).resizable()
        } else {
            return Image(systemName: "photo")
        }
    }
}

struct ItemCheaterView_Previews: PreviewProvider {
    static var previews: some View {
        ItemCheaterView()
    }
}
