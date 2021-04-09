//
//  Meals.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 19/03/21.
//

import Foundation
import os.log

class Meals: NSObject {
    
    func all() -> Array<Meal> {
        do {
            let fileData = try Data(contentsOf: Meal.ArchiveURL)
            guard let loadedMeals = try NSKeyedUnarchiver
                    .unarchiveTopLevelObjectWithData(fileData) as? Array<Meal> else { return [] }
            
            return loadedMeals
        } catch {
            os_log("Failed to load meals...", log: OSLog.default, type: .error)
            return []
        }
    }
    
    func saveAll(_ meals: Array<Meal>) {
        do {
            let mealData = try NSKeyedArchiver.archivedData(withRootObject: meals, requiringSecureCoding: false)
            
            try mealData.write(to: Meal.ArchiveURL)
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } catch {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
}
