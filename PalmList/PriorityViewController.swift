//
//  PriorityViewController.swift
//  PalmList
//
//  Created by Timothy Waters on 1/6/19.
//  Copyright © 2019 Timmy Waters Software. All rights reserved.
//

import UIKit

protocol SaveButtonDelegate {
    func saveButtonValue(value: String)
}

class PriorityViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var priorityPicker: UIPickerView!
    @IBOutlet weak var savePriorityButton: UIButton!
    
    var priorityChosen = ""
    var delegate: SaveButtonDelegate?
    
    let priorityLevel = ["1", "2", "3", "4", "5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.priorityPicker.dataSource = self
        self.priorityPicker.delegate = self
        self.priorityPicker.selectRow(0, inComponent: 0, animated: true)
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
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if priorityChosen != "" {
            self.delegate?.saveButtonValue(value: priorityChosen)
        }
        else {
            priorityChosen = "1"
            self.delegate?.saveButtonValue(value: priorityChosen)
        }
        dismiss(animated: true)
    }
}
