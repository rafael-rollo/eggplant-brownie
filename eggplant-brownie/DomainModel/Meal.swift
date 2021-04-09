//
//  Meal.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 25/02/21.
//

import Foundation

struct MealPropertyKey {
    static let name = "name"
    static let happinessLevel = "happinessLevel"
    static let items = "items"
}

class Meal: NSObject, NSCoding {
    
    static let ArchiveURL = FileManager()
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
        .appendingPathComponent("meals")

    let name: String
    let happinessLevel: Int
    var items: Array<Item> = []
    
    init(name: String, happinessLevel: Int, items: Array<Item> = []) {
        self.name = name
        self.happinessLevel = happinessLevel
        self.items = items
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: MealPropertyKey.name)
        coder.encode(happinessLevel, forKey: MealPropertyKey.happinessLevel)
        coder.encode(items, forKey: MealPropertyKey.items)
    }
    
    required convenience init?(coder: NSCoder) {
        let name = coder.decodeObject(forKey: MealPropertyKey.name) as! String
        let happinessLevel = coder.decodeInteger(forKey: MealPropertyKey.happinessLevel)
        let items = coder.decodeObject(forKey: MealPropertyKey.items) as! Array<Item>
        
        self.init(name: name, happinessLevel: happinessLevel, items: items)
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
        return """
            Happiness level: \(self.happinessLevel)
            Total calories: \(self.totalCalories()) kcal
        """
    }
}
