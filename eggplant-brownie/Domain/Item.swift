//
//  Item.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 25/02/21.
//

import UIKit

class Item: NSObject {

    var name: String
    var calories: Double
    
    init(name: String, calories: Double) {
        self.name = name
        self.calories = calories
    }
}
