//
//  MainListViewController.swift
//  PalmList
//
//  Created by Timothy Waters on 1/6/19.
//  Copyright © 2019 Timmy Waters Software. All rights reserved.
//

import UIKit
import CoreData

var defaultCell = "defaultCell"
var itemIndex = 0
var testData: [String] = []
var listItem: [(isChecked: Bool, priorityLevel: String, itemText: String)] = []

class MainListViewController: UITableViewController, PriorityDelegate, SaveButtonDelegate{
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var itemTF = UITextField()
    var cellIndexPath = 0
    var priorityValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCell, for: indexPath) as! ListItemCell
        cell.itemLabel.text = testData[indexPath.row]
        cell.delegate = self
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicked(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func checkButtonClicked(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        }
        else {
            sender.isSelected = true
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemIndex = indexPath.row
        performSegue(withIdentifier: "segueID", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        testData.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "PalmList", message: "Add an item to your list", preferredStyle: .alert)
        
        alertController.addTextField { (itemTF) in itemTF.placeholder = "Your item goes here" }
        
        // Create OK button
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            guard let itemText = alertController.textFields?.first?.text else {return}
            
            self.add(itemText)
            
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
    
    func add(_ newItem: String) {
        testData.insert(newItem, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
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
        cell.priorityButton.setTitle(value, for: .normal)
        priorityValue = value
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let vc : PriorityViewController = segue.destination as! PriorityViewController
            vc.delegate = self
        }
    }
}
