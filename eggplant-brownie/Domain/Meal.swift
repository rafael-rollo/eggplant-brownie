//
//  Meal.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 25/02/21.
//

import UIKit

class Meal: NSObject {

    let name: String
    let happinessLevel: Int
    var items: Array<Item> = []
    
    init(name: String, happinessLevel: Int, items: Array<Item> = []) {
        self.name = name
        self.happinessLevel = happinessLevel
        self.items = items
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
