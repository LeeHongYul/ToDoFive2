//
//  ViewController.swift
//  ToDoFive
//
//  Created by 이홍렬 on 2023/01/20.
//

import UIKit

class TodoListViewController: UITableViewController {

        var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first? .appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //print(dataFilePath)
        // Do any additional setup after loading the view.
        //let newItem = Item()
        //newItem.title = "Find"
        //itemArray.append(newItem)
        
        //let newItem2 = Item()
        //newItem2.title = "Finddsdadasd"
        //itemArray.append(newItem2)
        
        //let newItem3 = Item()
        //newItem3.title = "Fqweinasdfad"
       // itemArray.append(newItem3)
        
        loadItems()
        
        
 //       if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
  //          itemArray = items
  //      }
    }

    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "String?")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        /* if item.done == true
        {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        */
        
    return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
  /*      if itemArray[indexPath.row].done == false{
            itemArray[indexPath.row].done = true
        }else{
            itemArray[indexPath.row].done = false
        }
  */
        tableView.reloadData()
        
 /*       if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
  
  */
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
       
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
           let encoder = PropertyListEncoder()
            
            do{
                let data = try encoder.encode(self.itemArray)
                try data.write(to: self.dataFilePath!)
            } catch {
                print("Error coding item array, \(error)")
            }
            
            
            self.tableView.reloadData()
        }
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated:  true, completion: nil)
}
    
    func SaveItems(){
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
        
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error dncoding item array, \(error)")
            }
            
        }
    }
}
