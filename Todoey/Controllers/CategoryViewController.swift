//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Vikkas Miittal on 09/04/18.
//  Copyright © 2018 SolutionInfotech. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    

    //var categoryArray = [Category]()
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            //self.categories.append(newCategory)
            self.saveItems(category: newCategory)
        }
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Category Name"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    //MARK: Tableview Datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        

        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    //MARK: Tablewview Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
    //Mark: Data Manipulation methods
    func saveItems(category: Category){
        do {
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print ("Error while saving \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory(){
       
        categories =  realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    
}

