//
//  GridView.swift
//  StrayCompanion
//
//  Created by Luis Hankel on 02/03/2020.
//  Copyright © 2020 Luis Hankel. All rights reserved.
//

import SwiftUI

struct Grid<ItemType: Hashable, Content: View>: View {
    let items: [ItemType]
    let chunkSize: Int
    var itemSize: Double {
        return 1.0 / Double(chunkSize)
    }
    let alignment: HorizontalAlignment
    let content: (ItemType) -> Content
    
    init(items: [ItemType], chunkSize: Int = 3, alignment: HorizontalAlignment = .center, @ViewBuilder content: @escaping (ItemType) -> Content) {
        self.items = items
        self.chunkSize = chunkSize
        self.alignment = alignment
        self.content = content
    }
    
    var body: some View {
        GeometryReader { metrics in
            ScrollView {
                VStack(alignment: self.alignment) {
                    ForEach(self.items.chunked(size: self.chunkSize), id: \.self) { itemRow in
                        HStack {
                            ForEach(itemRow, id: \.self) { item in
                                self.content(item).frame(maxWidth: metrics.size.width * CGFloat(self.itemSize))
                            }
                        }
                    }
                }
            }
        }
    }
}
