//
//  ViewController.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/14/17.
//
//

import UIKit
import SwiftyJSON
import PromiseKit

class ViewController: UIViewController {
    @IBOutlet fileprivate weak var webView: UIWebView!
    
    fileprivate var eventBus: EventBus!
    fileprivate let authenticationService: AuthenticationServiceProtocol = AuthenticationService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeEventBus()
        
        let urlString = "https://bouncer.outcome-hub.com/auth/realms/genny/account"
        guard let keyCloakURL = URL(string: urlString) else { return }
        
        let keyCloakRequest = URLRequest(url: keyCloakURL)
        webView.loadRequest(keyCloakRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Private
extension ViewController {
    
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
        
        /*do {
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
        }*/
    }
}

// MARK: - IBAction
extension ViewController {
    
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

// MARK: - UIWebViewDelegate
extension ViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView,
                 shouldStartLoadWith request: URLRequest,
                 navigationType: UIWebViewNavigationType) -> Bool {
        guard let address = request.url?.absoluteString else { return true }
        guard address.contains("login-redirect?") else { return true }
        
        performSegue(withIdentifier: "main", sender: nil)
        
        return true
    }
}
