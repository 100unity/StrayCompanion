//
//  Item.swift
//  StrayCompanion
//
//  Created by Luis Hankel on 02/03/2020.
//  Copyright © 2020 Luis Hankel. All rights reserved.
//

struct Item: Hashable, PacketData, Equatable {
    let name: String
    private(set) var amount: Int
    
    var displayName: String {
        name.splitBefore { char in String(char) == char.uppercased() }
            .map { String($0) }
            .joined(separator: " ")
    }
    
    var icon: String {
        name.prefix(1).lowercased() + name.dropFirst()
    }
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        lhs.name == rhs.name
    }
    
    mutating func addOne() {
        amount += 1
    }
    
    mutating func removeOne() {
        amount -= 1
    }
    
    enum CodingKeys: String, CodingKey {
        case name, amount
    }
}

extension Array: PacketData where Element == Item {}
