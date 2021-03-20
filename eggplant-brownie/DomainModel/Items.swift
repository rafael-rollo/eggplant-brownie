//
//  Items.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 19/03/21.
//

import Foundation

class Items: NSObject {
    
    static let fileName: String = "meal-items"
    
    private func getFilePath() -> URL? {
        guard let appDocumentsDirectory = FileManager.default
                .urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let itemsFilePath = appDocumentsDirectory.appendingPathComponent(Items.fileName)
        return itemsFilePath
    }
    
    func all() -> Array<Item> {
        guard let itemsFilePath = self.getFilePath() else { return [] }
        
        do {
            let fileData = try Data(contentsOf: itemsFilePath)
            guard let loadedItems = try NSKeyedUnarchiver
                    .unarchiveTopLevelObjectWithData(fileData) as? Array<Item> else { return [] }
            
            return loadedItems
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveAll(_ items: Array<Item>) {
        guard let itemsFilePath = self.getFilePath() else { return }
        
        do {
            let itemsData = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
            try itemsData.write(to: itemsFilePath)
        } catch {
            print(error.localizedDescription)
        }
    }
}
