//
//  MainViewController.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/18/17.
//  Copyright © 2017 OutcomeLife. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var reconnectButton: UIButton!
    @IBOutlet weak var responseLabel: UILabel!
    
    fileprivate let manager = EventBusManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.add(listener: self)
        
        guard manager.isConnected else { return }
        
        managerDidConnect()
    }
}

// MARK: - IBAction
extension MainViewController {
    
    @IBAction fileprivate func didTapButton() {
        manager.publish(data: ["message": "hello from ios!"])
    }
    
    @IBAction fileprivate func didTapReconnectButton() {
        manager.connect()
    }
}

// MARK: - EventBusManagerDelegate
extension MainViewController: EventBusManagerDelegate {
    
    func managerDidConnect() {
        DispatchQueue.main.async {
            self.sendButton.isEnabled = true
            self.reconnectButton.isEnabled = false
        }
    }
    
    func managerDidDisconnect() {
        DispatchQueue.main.async {
            self.sendButton.isEnabled = false
            self.reconnectButton.isEnabled = true
        }
    }
    
    func manager(didReceiveError error: Error) {
        var title = "Error"
        var message = error.localizedDescription
        if let eventBusError = error as? EventBus.Error {
            switch eventBusError {
            case .disconnected:
                title = "Disconnected"
                message = "You have been disconnected!"
            case .invalidData:
                title = "Invalid Data"
                message = "Server passed invalid data"
            case .serverError:
                title = "Server Error"
                message = "Server encountered an error from request"
            }
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func manager(didReceiveMessage message: Message) {
        DispatchQueue.main.async {
            self.responseLabel.text = message.body["message"].stringValue
        }
    }
}
