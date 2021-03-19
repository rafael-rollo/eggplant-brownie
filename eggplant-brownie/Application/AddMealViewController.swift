//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 25/02/21.
//

import UIKit

protocol AddMealViewControllerDelegate {
    func updateMealListWith(_ meal: Meal)
}

class AddMealViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddNewItemViewControllerDelegate {
    
    // MARK: Attributes
    
    var delegate: AddMealViewControllerDelegate?
    var items: [Item] = [
        Item(name: "Bread", calories: 120),
        Item(name: "Toast", calories: 100),
        Item(name: "Cheese", calories: 70),
        Item(name: "Ham", calories: 92)
    ];
    var selectedItems: [Item] = []

    // MARK: IBOutlets
    
    @IBOutlet var mealNameTextField: UITextField?
    @IBOutlet var happinessLevelTextField: UITextField?
    @IBOutlet weak var itemsTableView: UITableView!
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        let navigationButton = UIBarButtonItem(title: "Add Item", style: .plain, target: self, action: #selector(navigatoToNewItemScene))
        navigationItem.rightBarButtonItem = navigationButton
    }
    
    // MARK: Navigation links and controls
    
    @objc func navigatoToNewItemScene() {
        let addNewItemViewController = AddNewItemViewController(delegate: self)
        navigationController?.pushViewController(addNewItemViewController, animated: true)
    }

    // MARK: UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = self.items[indexPath.row].name
        
        return cell
    }
    
    // MARK: UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        let selectedItem = self.items[indexPath.row]
        
        if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
            self.selectedItems.append(selectedItem)

        } else {
            cell.accessoryType = .none
            
            guard let indexOfSelectedItem = self.selectedItems.firstIndex(of: selectedItem) else { return }
            self.selectedItems.remove(at: indexOfSelectedItem)
        }
    }
    
    // MARK: IBActions
    
    @IBAction func addMeal(_ sender: Any) {
        guard let mealName = self.mealNameTextField?.text,
              let happinessLevelAsString = self.happinessLevelTextField?.text else {
            return
        }
        
        guard let happinessLevel = Int(happinessLevelAsString) else {
            print("Invalid happiness level value")
            return
        }
        
        let meal = Meal(name: mealName, happinessLevel: happinessLevel, items: self.selectedItems)
    
        print("The user ates \(meal.name) and got a happiness level of \(meal.happinessLevel)")
        
        self.delegate?.updateMealListWith(meal)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: View methods
    
    func updateItemsListWith(_ item: Item) {
        self.items.append(item);
        self.itemsTableView.reloadData()
    }
}

