//
//  Item.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 25/02/21.
//

import Foundation

class Item: NSObject, NSCoding {
    var name: String
    var calories: Double
    
    init(name: String, calories: Double) {
        self.name = name
        self.calories = calories
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name");
        coder.encode(calories, forKey: "calories");
    }
    
    required init?(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: "name") as! String
        self.calories = coder.decodeDouble(forKey: "calories")
    }
}
