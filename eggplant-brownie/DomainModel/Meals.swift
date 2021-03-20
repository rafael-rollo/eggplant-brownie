//
//  Meals.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 19/03/21.
//

import Foundation

class Meals: NSObject {
    
    static let fileName: String = "meals"
    
    private func getFilePath() -> URL? {
        guard let appDocumentsDirectory = FileManager.default
                .urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let mealsFilePath = appDocumentsDirectory.appendingPathComponent(Meals.fileName)
        return mealsFilePath
    }
    
    func all() -> Array<Meal> {
        guard let mealsFilePath = self.getFilePath() else { return [] }
        
        do {
            let fileData = try Data(contentsOf: mealsFilePath)
            guard let loadedMeals = try NSKeyedUnarchiver
                    .unarchiveTopLevelObjectWithData(fileData) as? Array<Meal> else { return [] }
            
            return loadedMeals
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveAll(_ meals: Array<Meal>) {
        guard let mealsFilePath = self.getFilePath() else { return }
        
        do {
            let mealData = try NSKeyedArchiver.archivedData(withRootObject: meals, requiringSecureCoding: false)
            try mealData.write(to: mealsFilePath)
        } catch {
            print(error.localizedDescription)
        }
    }
}
