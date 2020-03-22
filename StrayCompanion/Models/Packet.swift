//
//  Packet.swift
//  StrayCompanion
//
//  Created by Luis Hankel on 02/03/2020.
//  Copyright © 2020 Luis Hankel. All rights reserved.
//

import Foundation

protocol Packet: Codable {
    var type: String { get }
    var data: PacketData { get set }
}

protocol PacketData: Codable {}
