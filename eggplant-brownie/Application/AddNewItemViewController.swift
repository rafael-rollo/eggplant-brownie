//
//  AddNewItemViewController.swift
//  eggplant-brownie
//
//  Created by Rafael Rollo on 01/03/21.
//

import UIKit

protocol AddNewItemViewControllerDelegate {
    func updateItemsList(with item: Item)
}

class AddNewItemViewController: UIViewController {

    // MARK: Atributes
    
    var delegate: AddNewItemViewControllerDelegate?
    
    // MARK: Constructors
    
    init(delegate: AddNewItemViewControllerDelegate) {
        super.init(nibName: "AddNewItemViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: IBOutlets
    
    @IBOutlet weak var itemNameTextField: UITextField?
    @IBOutlet weak var itemCaloriesTextField: UITextField!
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: IBActions
    
    @IBAction func addItem(_ sender: Any) {
        guard let itemName = itemNameTextField?.text,
              let itemCaloriesAsString = itemCaloriesTextField?.text else { return }
        
        guard let itemCalories = Double(itemCaloriesAsString) else {
            print("Invalid caloried value!")
            return
        }
        
        let newItem = Item(name: itemName, calories: itemCalories)
        delegate?.updateItemsList(with: newItem)
        
        navigationController?.popViewController(animated: true)
    }
    
}
