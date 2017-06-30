//
//  MainViewController.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/18/17.
//  Copyright © 2017 OutcomeLife. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    fileprivate var eventBus: EventBus!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeEventBus()
    }
}

// MARK: - Private
extension MainViewController {
    
    fileprivate func initializeEventBus() {
        eventBus = EventBus(host: "localhost", port: 8081)
        
        do {
            try eventBus.connect()
            
            do {
                _ = try eventBus.register(address: "address.outbound") { message in
                    print("got message \(message.body)")
                }
            } catch let error {
                print("Error Registering: " + error.localizedDescription)
            }
            
        } catch let error {
            print("Error Connecting: " + error.localizedDescription)
        }
    }
}

// MARK: - IBAction
extension MainViewController {
    
    @IBAction fileprivate func didTapButton() {
        do {
            try eventBus.publish(to: "address.inbound", body: ["message": "hello from ios!"])
        } catch let error {
            print("Error Publishing: " + error.localizedDescription)
        }
    }
}
