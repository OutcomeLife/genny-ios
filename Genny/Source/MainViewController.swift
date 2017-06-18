//
//  MainViewController.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/18/17.
//
//

import UIKit
import SwiftyJSON

final class MainViewController: UIViewController {

    fileprivate var eventBus: EventBus!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeEventBus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Private
extension MainViewController {
    
    fileprivate func initializeEventBus() {
        eventBus = EventBus(host: "10.5.12.113/eventbus", port: 8081)
        eventBus.register { print("register error: \($0)") }
        
        do {
            signal(SIGPIPE, SIG_IGN)
            var value = 1;
            setsockopt(8081, SOL_SOCKET, SO_NOSIGPIPE, &value, socklen_t(sizeof(Int.self)));
            try eventBus.connect()
        } catch let error {
            print("error connect:\(error)")
        }
        
        do {
            _ = try eventBus.register(address: "address.outbound",
                                      id: "1",
                                      headers: ["hello": "world"], handler: { _ in })
            
            do {
                let json = JSON(arrayLiteral: ["message", "hello from ios"])
                try eventBus.publish(to: "address.inbound", body: ["json": json])
            } catch let error {
                print("error send: \(error)")
            }
        } catch let error {
            print("error reg:\(error)")
        }
    }
}

// MARK: - IBAction
extension MainViewController {
    
    @IBAction fileprivate func didTapButton() {
        guard eventBus.connected() else { return }
        
        let json = JSON(arrayLiteral: ["message", "hello from ios"])
        do {
            try eventBus.publish(to: "address.inbound", body: ["json": json])
        } catch let error {
            print("error send: \(error)")
        }
    }
}
