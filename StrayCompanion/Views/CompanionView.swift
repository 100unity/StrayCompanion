//
//  CompanionView.swift
//  StrayCompanion
//
//  Created by Luis Hankel on 01/03/2020.
//  Copyright © 2020 Luis Hankel. All rights reserved.
//

import SwiftUI

struct CompanionView: View {
    @EnvironmentObject var model: CompanionModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: { withAnimation {
                    self.model.disconnect()
                }}) {
                    Image(systemName: "arrow.left")
                    Text("Disconnect")
                }
                Spacer()
            }.padding()
            
            TabView {
                InventoryView()
                    .tabItem {
                        Image(systemName: "square.grid.3x2.fill")
                        Text("Inventory")
                    }
                ItemCheaterView()
                    .tabItem {
                        Image(systemName: "plus.square.fill.on.square.fill")
                        Text("Item Cheater")
                    }
            }
        }
    }
}

struct CompanionView_Previews: PreviewProvider {
    static var previews: some View {
        CompanionView().environmentObject({ () -> CompanionModel in 
            let model = CompanionModel()
            model.itemList = [
                Item(name: "Wood", amount: 3),
                Item(name: "Stone", amount: 5),
                Item(name: "IronPickaxe", amount: 1)
            ]
            return model
        }())
    }
}
