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
    }
    
    func addItem(item: Item) {
        self.items.append(item)
    }
    
    func totalCalories() -> Double {
        self.items
            .map { $0.calories }
            .reduce(0, { current, next in
                current + next
            })
    }
}
