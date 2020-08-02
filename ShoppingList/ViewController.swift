//
//  ViewController.swift
//  Consolidation3
//
//  Created by Damnjan Markovic on 25/07/2020.
//  Copyright © 2020 Damnjan Markovic. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [(String, Int)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping list"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProduct))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeAllItems))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommendTapped))
    }
    
    @objc func removeAllItems() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    @objc func recommendTapped() {
        
        var listItems = [String]()
        for item in shoppingList {
            listItems.append("\(item.0.capitalized) - \(item.1)")
        }
        
        let listForShopping = listItems.joined(separator: ";\n")
        
        
        let vc = UIActivityViewController(activityItems: [listForShopping], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    


    @objc func addProduct() {
        
        let ac = UIAlertController(title: "Add item and quantity", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "item"
        }
        ac.addTextField { (textField) in
            textField.placeholder = "quantity"
        }

        let submitAction = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] action in


            guard let item = ac?.textFields?[0].text else { return }
            guard let quantity = ac?.textFields?[1].text else { return }
            guard let quantityInt = Int(quantity) else { return }
            if item.isEmpty || quantityInt <= 0 {
                return
            } else {
                self?.submit(item, quantityInt)
            }
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Item:\t\t \(shoppingList[indexPath.row].0.capitalized)"
        cell.textLabel?.font = UIFont(name: "Helvetica Neue", size: 17)
        cell.detailTextLabel?.text = "Quantity:\t \(shoppingList[indexPath.row].1)"
        cell.detailTextLabel?.font = UIFont(name: "Helvetica Neue", size: 17)
        return cell
    }
    

    
    func submit(_ item: String,_ quantity: Int) {
        shoppingList.insert((item, quantity), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)

    }


}

