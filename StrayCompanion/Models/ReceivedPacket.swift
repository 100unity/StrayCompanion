//
//  ReceivedPacket.swift
//  StrayCompanion
//
//  Created by Luis Hankel on 02/03/2020.
//  Copyright © 2020 Luis Hankel. All rights reserved.
//

struct ReceivedPacket: Decodable {
    let type: String
    
    struct UnknownTypeError: Error {}
}
