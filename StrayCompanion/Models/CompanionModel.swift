//
//  CompanionModel.swift
//  StrayCompanion
//
//  Created by Luis Hankel on 01/03/2020.
//  Copyright © 2020 Luis Hankel. All rights reserved.
//

import Foundation

class CompanionModel: ObservableObject {
    private var connection: SocketConnection?
    private let decoder = JSONDecoder()
    
    @Published var connected = false
    @Published var receivedData = ""
    @Published var itemList = [Item]()
    
    func connect(host: String, port: UInt16) {
        connection = SocketConnection(host: host, port: port)
        connection?.setStopCallback { error in
            if let error = error {
                print("Error: \(error)")
            }
        }
        connection?.setDidReceiveCallback { packet in
            DispatchQueue.main.async {
                self.handlePacket(packet: packet)
            }
        }
        connection?.receive()
        
        connected = true
    }
    
    func disconnect() {
        connection?.stop()
        connection = nil
        connected = false
    }
    
    func addItem(item: Item) {
        send(data: AddOnePacket(item: item))
    }
    
    func deleteOne(item: Item) {
        send(data: DeleteOnePacket(item: item))
    }
    
    func deleteAll(item: Item) {
        send(data: DeleteAllPacket(item: item))
    }
    
    private func send<TPacket>(data: TPacket) where TPacket: Encodable {
        do {
            connection?.send(data: try JSONEncoder().encode(data))
        } catch {
            print(error)
            print("Error handling packet: \(data)")
        }
    }
    
    private func handlePacket(packet: Data) {
        do {
            let receivedPacket = try decoder.decode(ReceivedPacket.self, from: packet)
            switch receivedPacket.type {
            case "inventory":
                let inventoryPacket = try decoder.decode(InventoryPacket.self, from: packet)
                itemList = inventoryPacket.inventory
            case "addOne":
                let addOnePacket = try decoder.decode(AddOnePacket.self, from: packet)
                if let index = itemList.firstIndex(of: addOnePacket.item) {
                    itemList[index].addOne()
                } else {
                    itemList.append(addOnePacket.item)
                }
            case "deleteOne":
                let deleteOnePacket = try decoder.decode(DeleteOnePacket.self, from: packet)
                guard let index = itemList.firstIndex(of: deleteOnePacket.item) else {
                    break
                }
                itemList[index].removeOne()
                if itemList[index].amount <= 0 {
                    itemList.remove(at: index)
                }
            default:
                throw ReceivedPacket.UnknownTypeError()
            }
        } catch {
            print(error)
            print("Error handling packet: \(String(decoding: packet, as: UTF8.self))")
        }
    }
}
