//
//  MealInformativeAlert.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 19/03/21.
//

import UIKit

class MealInfoAlert: Alert {
    
    init(controller: UIViewController, removeHandler: @escaping ((UIAlertAction) -> Void)) {
        let actions = [
            UIAlertAction(title: "Remove", style: .destructive, handler: Optional.some(removeHandler))
        ]
        
        super.init(controller: controller, actions: actions)
    }
}
