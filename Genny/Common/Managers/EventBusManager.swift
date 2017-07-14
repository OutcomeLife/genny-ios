//
//  EventBusManager.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 7/14/17.
//  Copyright © 2017 OutcomeLife. All rights reserved.
//

import Foundation

protocol EventBusManagerDelegate: class {
    
    func managerDidConnect()
    func managerDidDisconnect()
    func manager(didReceiveError error: Error)
}

final class EventBusManager: NSObject {
    
    fileprivate let eventBus: EventBus!
    fileprivate var listeners: [EventBusManagerDelegate] = []
    static let shared = EventBusManager()
    
    var isConnected: Bool {
        return eventBus.connected()
    }
    
    override private init() {
        eventBus = EventBus(host: "localhost", port: 8081)
        super.init()
        connect()
    }
    
    func add(listener: EventBusManagerDelegate) {
        listeners.append(listener)
    }
    
    func remove(listener: EventBusManagerDelegate) {
        var indexToRemove = 0
        for (index, delegate) in listeners.enumerated() where listener === delegate {
            indexToRemove = index
        }
        
        listeners.remove(at: indexToRemove)
    }
    
    func connect() {
        do {
            try eventBus.connect()
            listeners.forEach { $0.managerDidConnect() }
            
            do {
                _ = try eventBus.register(address: "address.outbound") { message in
                    print("Message: \(message.body)")
                }
                
                eventBus.register(errorHandler: { error in
                    switch error {
                    case .disconnected:
                        self.listeners.forEach { $0.managerDidDisconnect() }
                    case .invalidData, .serverError:
                        self.listeners.forEach { $0.manager(didReceiveError: error) }
                    }
                })
            } catch let error {
                listeners.forEach { $0.manager(didReceiveError: error) }
            }
        } catch let error {
            listeners.forEach { $0.manager(didReceiveError: error) }
        }
    }
    
    func publish(data: [String: Any]) {
        guard eventBus.connected() else { print("dc-ed"); return }
        
        do {
            try eventBus.publish(to: "address.inbound", body: data)
        } catch let error {
            listeners.forEach { $0.manager(didReceiveError: error) }
        }
    }
}
