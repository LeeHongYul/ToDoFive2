//
//  ViewController.swift
//  ToDoFive
//
//  Created by 이홍렬 on 2023/01/20.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

        var itemArray = [Item]()
    
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first? .appendingPathComponent("Items.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // searchBar.delegate = self
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
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
        
        //itemArray[indexPath.row].setValue("Completed", forKey: "title")
        //itemArray.remove(at: indexPath.row)
        //context.delete(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        SaveItems()
        
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
           
            
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            
            self.SaveItems()
        }
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated:  true, completion: nil)
}
    
    func SaveItems(){
        
        
        do{
            
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
   func loadItems() {
        
       let request : NSFetchRequest<Item> = Item.fetchRequest()
       do{
           
       itemArray = try context.fetch(request)
       
       } catch {
           
       print("Error fetching data from context \(error)")
       }
       }
    

}

//MARK - Seach Bar methods
extension TodoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS %@", searchBar.text!)
        
    }
}
