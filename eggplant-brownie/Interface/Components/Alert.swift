//
//  Alert.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 05/03/21.
//

import UIKit

class Alert {
    
    let controller: UIViewController
    let actions: [UIAlertAction]
    
    init(controller: UIViewController, actions: [UIAlertAction] = []) {
        self.controller = controller
        
        let defaultActions = [
            UIAlertAction(title: "Cancel", style: .cancel)
        ]
        self.actions = defaultActions + actions
    }
    
    func show(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        actions.forEach { action in
            alert.addAction(action)
        }
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    func show(message: String) {
        self.show(title: nil, message: message)
    }
}
