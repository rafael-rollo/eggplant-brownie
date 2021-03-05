//
//  Alert.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 05/03/21.
//

import UIKit

class Alert {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func show(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        
        controller.present(alert, animated: true, completion: nil)
    }
}
