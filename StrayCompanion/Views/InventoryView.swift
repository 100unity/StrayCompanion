//
//  InventoryView.swift
//  StrayCompanion
//
//  Created by Luis Hankel on 02/03/2020.
//  Copyright © 2020 Luis Hankel. All rights reserved.
//

import SwiftUI

struct InventoryView: View {
    @EnvironmentObject var model: CompanionModel
    
    var body: some View {
        Grid(items: model.itemList) { item in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    self.iconImage(icon: item.icon)
                        .scaledToFit()
                    self.amountLabel(amount: item.amount)
                        .font(.system(size: 24, weight: .semibold, design: .default))
                }
                Text(item.displayName)
            }.contextMenu {
                Button(action: { self.model.deleteOne(item: item) }) {
                    Image(systemName: "trash")
                    Text("Delete one")
                }
                Button(action: { self.model.deleteAll(item: item) }) {
                    Image(systemName: "trash")
                    Text("Delete all")
                }
            }
        }.padding()
    }
}

extension InventoryView {
    func iconImage(icon: String?) -> some View {
        if let icon = icon {
            return Image(icon).resizable()
        } else {
            return Image(systemName: "photo")
        }
    }
    
    func amountLabel(amount: Int) -> some View {
        if amount > 1 {
            return AnyView(Text("\(amount)x"))
        } else {
            return AnyView(EmptyView())
        }
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView().environmentObject({ () -> CompanionModel in
            let model = CompanionModel()
            model.itemList = [
                Item(name: "Wood", amount: 3),
                Item(name: "Stone", amount: 5),
                Item(name: "Pickaxe", amount: 1)
            ]
            return model
        }())
    }
}
