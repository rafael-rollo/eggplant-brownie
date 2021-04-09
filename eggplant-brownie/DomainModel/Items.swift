//
//  Items.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 19/03/21.
//

import Foundation

class Items: NSObject {
    
    func all() -> Array<Item> {
        do {
            let fileData = try Data(contentsOf: Item.ArchiveURL)
            guard let loadedItems = try NSKeyedUnarchiver
                    .unarchiveTopLevelObjectWithData(fileData) as? Array<Item> else { return [] }
            
            return loadedItems
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveAll(_ items: Array<Item>) {
        do {
            let itemsData = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
            try itemsData.write(to: Item.ArchiveURL)
        } catch {
            print(error.localizedDescription)
        }
    }
}
