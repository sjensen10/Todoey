//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Sam Jensen on 1/25/18.
//  Copyright © 2018 SamJensen. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadCategories()

    }
    
    //Mark: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        
        return cell
    }
    
    //Mark: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            
            
            self.save(category: newCategory)
            
            
        }
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    
    //Mark: - Data Manipulaiton Methods
    
    func save(category: Category){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch{
            print("Error saving category\(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(){
       categories = realm.objects(Category.self)

    }
    
           //Mark: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desitinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            desitinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
        
    }
    
    
    

    
    
    

