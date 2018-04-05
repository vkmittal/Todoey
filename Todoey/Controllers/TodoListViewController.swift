//
//  ViewController.swift
//  Todoey
//
//  Created by Vikkas Miittal on 02/04/18.
//  Copyright © 2018 SolutionInfotech. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        print(dataFilePath)
        
//        let newItem = Item()
//        newItem.title = "Projects"
//        itemArray.append(newItem)
//        
//        let newItem2 = Item()
//        newItem2.title = "Holiday"
//        itemArray.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.title = "Movies"
//        itemArray.append(newItem3)
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//        }
        
        loadItems()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        //cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.textLabel?.text = item.title
        
        //if itemArray[indexPath.row].done == true {
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }
//        else {
//            cell.accessoryType = .none
//        }
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done  = true
//        }
//        else {
//            itemArray[indexPath.row].done  = false
//        }
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item to the list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.saveItems()
            //self.itemArray.append(textField.text!)
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Item Name"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model manipulation methods
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch{
            print("Error encoding item array \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems(){
        if  let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }
            catch {
                 print("Error decoding item array \(error)")
            }
            
        }
    }


}

