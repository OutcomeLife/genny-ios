//
//  MainViewController.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/18/17.
//  Copyright © 2017 OutcomeLife. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    
    fileprivate let manager = EventBusManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - IBAction
extension MainViewController {
    
    @IBAction fileprivate func didTapButton() {
        manager.publish(data: ["message": "hello from ios!"])
    }
    }
}

    
        }
    }
}
