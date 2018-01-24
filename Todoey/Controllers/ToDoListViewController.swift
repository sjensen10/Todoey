//
//  ViewController.swift
//  Todoey
//
//  Created by Sam Jensen on 1/23/18.
//  Copyright © 2018 SamJensen. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
       
        loadItems()
        
        
        
        
        
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Mark - Tableview DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
        return cell
    }
    
    // Mark - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
       saveItems()
      
        tableView.deselectRow(at: indexPath,  animated: true)
    }
    
  // Mark - Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new to do item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
           self.saveItems()
            
            
        }
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // Mark - Model Manipulation Methods
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
       if let data =  try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
        do{
            itemArray = try decoder.decode([Item].self, from: data)
        }catch{
            print("Error decoding item array, \(error)")
        }
        }
    }
    


}

