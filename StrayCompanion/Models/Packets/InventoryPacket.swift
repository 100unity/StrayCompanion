//
//  InventoryPacket.swift
//  StrayCompanion
//
//  Created by Luis Hankel on 02/03/2020.
//  Copyright © 2020 Luis Hankel. All rights reserved.
//

struct InventoryPacket: Packet {
    let type = "inventory"
    var data: PacketData
    
    var inventory: [Item] {
        return data as! [Item]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode([Item].self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(data as! [Item], forKey: .data)
    }
    
    enum CodingKeys: String, CodingKey {
        case type, data
    }
}
