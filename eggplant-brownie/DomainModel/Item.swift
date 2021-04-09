//
//  Item.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 25/02/21.
//

import Foundation

struct ItemPropertyKey {
    static let name = "name"
    static let calories = "calories"
}

class Item: NSObject, NSCoding {
    
    static let ArchiveURL = FileManager()
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
        .appendingPathComponent("meal-items")
    
    var name: String
    var calories: Double
    
    init(name: String, calories: Double) {
        self.name = name
        self.calories = calories
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: ItemPropertyKey.name);
        coder.encode(calories, forKey: ItemPropertyKey.calories);
    }
    
    required init?(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: ItemPropertyKey.name) as! String
        self.calories = coder.decodeDouble(forKey: ItemPropertyKey.calories)
    }
}
