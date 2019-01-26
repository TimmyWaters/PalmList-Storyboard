//
//  MainListViewController.swift
//  PalmList
//
//  Created by Timothy Waters on 1/6/19.
//  Copyright © 2019 Timmy Waters Software. All rights reserved.
//

import UIKit
import CoreData

class MainListViewController: UITableViewController, ListItemCellDelegate, SaveButtonDelegate{
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    var itemTF = UITextField()
    
    var listItems: [PalmListItem] = []
    
    var cellIndexPath = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//    func saveData() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//        let palmListItem = PalmListItem(context: context)
//
//        palmListItem.isChecked = true
//        palmListItem.priority = "2"
//        palmListItem.itemText = "Some stuff"
//
//        do {
//            try context.save()
//        }
//        catch let err {
//            print(err)
//        }
//    }
    
    func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = PalmListItem.createFetchRequest()
        request.returnsObjectsAsFaults = false
        
        if let results = try? context.fetch(request) {
            for result in results {
                listItems.insert(result, at: 0)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! ListItemCell
        cell.checkButton.isSelected = listItems[indexPath.row].isChecked
        cell.priorityButton.setTitle(listItems[indexPath.row].priority, for: .normal)
        cell.itemLabel.text = listItems[indexPath.row].itemText
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = PalmListItem.createFetchRequest()
        request.returnsObjectsAsFaults = false
        
        var items: [PalmListItem] = []
        
        if let results = try? context.fetch(request) {
            for result in results {
                items.insert(result, at: 0)
            }
        }
        context.delete(items[indexPath.row])
        
        do {
            try context.save()
        }
        catch let err {
            print(err)
        }

        listItems.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "PalmList", message: "Add an item to your list", preferredStyle: .alert)
        
        alertController.addTextField { (itemTF) in itemTF.placeholder = "Your item goes here" }
        
        // Create OK button
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            guard let itemText = alertController.textFields?.first?.text else {return}
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let palmListItem = PalmListItem(context: context)
            
            palmListItem.isChecked = false
            palmListItem.priority = "1"
            palmListItem.itemText = itemText
            
            do {
                try context.save()
            }
            catch let err {
                print(err)
            }
            
            self.listItems.insert(palmListItem, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .left)
        }
        
        alertController.addAction(OKAction)
        
        // Create Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) /* {
            (action:UIAlertAction!) in print("Cancel button tapped"); // Uncomment to make Cancel button do stuff
        } */
        alertController.addAction(cancelAction)
        
        // Present Dialog message
        self.present(alertController, animated: true, completion:nil)
    }
    
    func setPriorityLevel(cell: ListItemCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }
        cellIndexPath = indexPath.row
    }
    
    func saveButtonValue(value: String) {
        let indexPath = IndexPath(row: cellIndexPath, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! ListItemCell
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let request = PalmListItem.createFetchRequest()
        request.returnsObjectsAsFaults = false

        var items: [PalmListItem] = []

        if let results = try? context.fetch(request) {
            for result in results {
                items.insert(result, at: 0)
            }
        }
        
        items[indexPath.row].priority = value
        cell.priorityButton.setTitle(value, for: .normal)
        
        do {
            try context.save()
        }
        catch let err {
            print(err)
        }
        
        
    }
    
    func setChecked(cell: ListItemCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }
        let cell = tableView.cellForRow(at: indexPath) as! ListItemCell
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = PalmListItem.createFetchRequest()
        request.returnsObjectsAsFaults = false
        
        var items: [PalmListItem] = []
        
        if let results = try? context.fetch(request) {
            for result in results {
                items.insert(result, at: 0)
            }
        }
        
        if cell.checkButton.isSelected {
            cell.checkButton.isSelected = false
            items[indexPath.row].isChecked = false
//            listItems[indexPath.row].isChecked = false
        }
        else {
            cell.checkButton.isSelected = true
            items[indexPath.row].isChecked = true
//            listItems[indexPath.row].isChecked = true
        }
        
        do {
            try context.save()
        }
        catch let err {
            print(err)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let vc : PriorityViewController = segue.destination as! PriorityViewController
            vc.delegate = self
        }
    }
}
