//
//  MealTableViewController.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 26/02/21.
//

import UIKit

class AllMealsViewController: UITableViewController, AddMealViewControllerDelegate {
    
    var meals = [
        Meal(name: "Vegan Burguer", happinessLevel: 3),
        Meal(name: "Falafel", happinessLevel: 4),
        Meal(name: "Jacalhau", happinessLevel: 2)
    ];
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = self.meals[indexPath.row].name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id != "AddMeal" {
            return
        }
        
        guard let addMealViewController = segue.destination as? AddMealViewController else { return }
        addMealViewController.delegate = self
    }
    
    func updateTable(with meal: Meal) {
        meals.append(meal)
        tableView.reloadData()
    }
}
