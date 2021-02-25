//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 25/02/21.
//

import UIKit

protocol AddMealViewControllerDelegate {
    func updateTable(with meal: Meal)
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
    
    @objc func navigatoToNewItemScene() {
        let addNewItemViewController = AddNewItemViewController(delegate: self)
        navigationController?.pushViewController(addNewItemViewController, animated: true)
    }
    
    func updateItemsList(with item: Item) {
        items.append(item);
        itemsTableView.reloadData()
    }
    
    // MARK: UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = items[indexPath.row].name
        
        return cell
    }
    
    // MARK: UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        let selectedItem = items[indexPath.row]
        
        if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
            selectedItems.append(selectedItem)

        } else {
            cell.accessoryType = .none
            
            guard let indexOfSelectedItem = selectedItems.firstIndex(of: selectedItem) else { return }
            selectedItems.remove(at: indexOfSelectedItem)
        }
    }
    
    // MARK: IBActions
    
    @IBAction func addMeal(_ sender: Any) {
        guard let mealName = mealNameTextField?.text,
              let happinessLevelAsString = happinessLevelTextField?.text else {
            return
        }
        
        guard let happinessLevel = Int(happinessLevelAsString) else {
            print("Invalid happiness level value")
            return
        }
        
        let meal = Meal(name: mealName, happinessLevel: happinessLevel, items: selectedItems)
    
        print("The user ates \(meal.name) and got a happiness level of \(meal.happinessLevel)")
        
        delegate?.updateTable(with: meal)
        navigationController?.popViewController(animated: true)
    }
}

