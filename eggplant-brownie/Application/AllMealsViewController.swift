//
//  MealTableViewController.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 26/02/21.
//

import UIKit

class AllMealsViewController: UITableViewController, AddMealViewControllerDelegate {
    
    // MARK: Attributes
    
    var meals: Array<Meal> = [];
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        let loadedMeals = Meals().all()
        self.meals = loadedMeals
    }
    
    // MARK: UITableViewController implementations
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meals.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = self.meals[indexPath.row].name
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(showMealDetails(_:)))
        cell.addGestureRecognizer(longPressGesture)
        
        return cell
    }
    
    // MARK: Navigation links and controls
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id != "AddMeal" {
            return
        }
        
        guard let addMealViewController = segue.destination as? AddMealViewController else { return }
        addMealViewController.delegate = self
    }
    
    // MARK: View methods
    
    func updateMealListWith(_ meal: Meal) {
        self.meals.append(meal)
        self.tableView.reloadData()
        
        Meals().saveAll(self.meals)
    }
    
    func removeMeal(at index: Int) {
        self.meals.remove(at: index)
        self.tableView.reloadData()
    }
    
    @objc func showMealDetails(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state != .began { return }
        
        let cell = gesture.view as! UITableViewCell
        
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        let meal = self.meals[indexPath.row]
        
        let alert = MealInfoAlert(controller: self, removeHandler: { action in
            self.removeMeal(at: indexPath.row)
        })
        alert.show(title: meal.name, message: meal.details())
    }
}
