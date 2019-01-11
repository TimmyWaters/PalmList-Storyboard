//
//  MainListViewController.swift
//  PalmList
//
//  Created by Timothy Waters on 1/6/19.
//  Copyright © 2019 Timmy Waters Software. All rights reserved.
//

import UIKit

var defaultCell = "defaultCell"
var itemIndex = 0
var testData: [String] = []
var listItem: [(priorityLevel: Int, itemText: String)] = []

class MainListViewController: UITableViewController, PriorityDelegate {
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var itemTF = UITextField()
    var setIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCell, for: indexPath) as! ListItemCell
        cell.itemLabel.text = testData[indexPath.row]
        cell.priorityButton.addTarget(self, action: #selector(priorityButtonClicked(sender:)), for: .touchUpInside)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemIndex = indexPath.row
        performSegue(withIdentifier: "segueID", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(75)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        testData.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Alert title", message: "Message to display", preferredStyle: .alert)
        
        alertController.addTextField { (itemTF) in itemTF.placeholder = "Enter your item" }
        
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
    
    @objc func priorityButtonClicked(sender: UIButton) {
        print("Button pressed")
//        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let vc : PriorityViewController = segue.destination as! PriorityViewController
            vc.delegate = self
        }
    }
    
    func setPriorityLevel(level: Int) {
        print(level)
    }
}
