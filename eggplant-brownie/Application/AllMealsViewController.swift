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
       
       let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(showMealDetails(_:)))
       cell.addGestureRecognizer(longPressGesture)
       
       return cell
    }
    
    @objc func showMealDetails(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state != .began { return }
        
        let cell = gesture.view as! UITableViewCell
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let meal = meals[indexPath.row]
        
        Alert(controller: self)
            .show(title: meal.name, message: meal.details())
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
