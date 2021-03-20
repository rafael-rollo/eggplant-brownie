//
//  Meal.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 25/02/21.
//

import Foundation

class Meal: NSObject, NSCoding {

    let name: String
    let happinessLevel: Int
    var items: Array<Item> = []
    
    init(name: String, happinessLevel: Int, items: Array<Item> = []) {
        self.name = name
        self.happinessLevel = happinessLevel
        self.items = items
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.happinessLevel, forKey: "happinessLevel")
        coder.encode(self.items, forKey: "items")
    }
    
    required init?(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: "name") as! String
        self.happinessLevel = coder.decodeInteger(forKey: "happinessLevel")
        self.items = coder.decodeObject(forKey: "items") as! Array<Item>
    }
    
    
    func addItem(item: Item) {
        self.items.append(item)
    }
    
    func totalCalories() -> Double {
        return self.items
            .map { $0.calories }
            .reduce(0, { current, next in
                current + next
            })
    }
    
    func details() -> String {
        return "Happiness level: \(self.happinessLevel)\nTotal calories: \(self.totalCalories()) kcal"
    }
}
