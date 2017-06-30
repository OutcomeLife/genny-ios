//
//  ViewController.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/14/17.
//  Copyright © 2017 OutcomeLife. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet fileprivate weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://keycloak.pleasedproperty.com.au/auth/realms/Genny/account"
        guard let keyCloakURL = URL(string: urlString) else { return }
        
        let keyCloakRequest = URLRequest(url: keyCloakURL)
        webView.loadRequest(keyCloakRequest)
        webView.scrollView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UIWebViewDelegate
extension LoginViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView,
                 shouldStartLoadWith request: URLRequest,
                 navigationType: UIWebViewNavigationType) -> Bool {
        guard let address = request.url?.absoluteString else { return true }
        guard address.contains("login-redirect?") else { return true }
        
        performSegue(withIdentifier: "main", sender: nil)
        
        return true
    }
}

// MARK: - UIScrollViewDelegate
extension LoginViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
}
