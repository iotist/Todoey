//
//  ViewController.swift
//  Todoey
//
//  Created by AbdurRohman on 02/11/2018.
//  Copyright © 2018 AbdurRohman. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Uy"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Univer"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Ish"
        itemArray.append(newItem2)
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
        
    }

    //MARK: - TableView datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary operator ==> Bu uslub if/else operatotidan ancha qulay va qisqa
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none // pasdegi 5 qator kod bn birhil ishni bajaradi
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
        
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false { // yuqoridegi =! belgi shu 5 qatorga yozilgan
                                                      // kodni vazifasini bajaradi
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
      
    }

    
    // MARK: - Adding new items
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        var alertText = UITextField()
        
        let alert = UIAlertController(title: "Add Todoey Item", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // what will happen whne user clicks the ADD button..
           
            let newItem = Item()
            newItem.title = alertText.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        
       alert.addTextField { (alertTextField) in
        
        alertTextField.placeholder = "Type new item.."

            alertText = alertTextField
        
        }
        
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
}

