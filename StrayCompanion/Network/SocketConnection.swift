//
//  SocketConnection.swift
//  StrayCompanion
//
//  Created by Luis Hankel on 29/02/2020.
//  Copyright © 2020 Luis Hankel. All rights reserved.
//

import Foundation
import Network

class SocketConnection {
    private var connection: NWConnection?
    private var didStopCallback: ((Error?) -> Void)? = nil
    private var didReceiveCallback: ((Data) -> Void)? = nil
    
    init(host: String, port: UInt16) {
        let host = NWEndpoint.Host(host)
        let port = NWEndpoint.Port(integerLiteral: port)
        connection = NWConnection(host: host, port: port, using: .tcp)
        connection?.stateUpdateHandler = stateDidChange(to:)
        connection?.start(queue: .global())
    }

    func send(data: Data) {
        connection?.send(content: data, completion: .contentProcessed( { error in
            if let error = error {
                self.stop(error: error)
                return
            }
        }))
    }

    func receive() {
        connection?.receive(minimumIncompleteLength: 1, maximumLength: 65536) { (data, _, isComplete, error) in
            if let data = data, !data.isEmpty {
                print("Connection received data: \(String(decoding: data, as: UTF8.self))")
                if let callback = self.didReceiveCallback {
                    callback(data)
                }
            }
            if let error = error {
                self.stop(error: error)
            } else {
                self.receive()
            }
        }
    }

    func stop(error: Error? = nil) {
        connection?.stateUpdateHandler = nil
        connection?.cancel()
        if let didStopCallback = didStopCallback {
            self.didStopCallback = nil
            didStopCallback(error)
        }
    }
    
    func setStopCallback(callback: @escaping (Error?) -> Void) {
        didStopCallback = callback
    }
    
    func setDidReceiveCallback(callback: @escaping (Data) -> Void) {
        didReceiveCallback = callback
    }

    private func stateDidChange(to state: NWConnection.State) {
        switch state {
        case .setup:
            break
        case .waiting(let error):
            self.stop(error: error)
        case .preparing:
            print("Connecting...")
        case .ready:
            print("Connected!")
        case .failed(let error):
            self.stop(error: error)
        case .cancelled:
            print("Disconnected!")
        default:
            break
        }
    }
}
