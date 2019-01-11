//
//  PriorityViewController.swift
//  PalmList
//
//  Created by Timothy Waters on 1/6/19.
//  Copyright © 2019 Timmy Waters Software. All rights reserved.
//

import UIKit

protocol PriorityDelegate {
    func setPriorityLevel(level: Int)
}

class PriorityViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var priorityPicker: UIPickerView!
    @IBOutlet weak var savePriorityButton: UIButton!
    
    var priorityChosen = ""
    var priorityIndex = 0
    var delegate : PriorityDelegate?
    
    let priorityLevel = ["1", "2", "3", "4", "5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorityLevel.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorityLevel[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priorityChosen = priorityLevel[row]
        priorityIndex = row
    }
    
    @IBAction func savePriority(_ sender: UIButton) {
        if delegate != nil {
            delegate?.setPriorityLevel(level: priorityIndex)
        }
        
        dismiss(animated: true)
    }
}
