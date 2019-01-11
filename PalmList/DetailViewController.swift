//
//  DetailViewController.swift
//  PalmList
//
//  Created by Timothy Waters on 1/6/19.
//  Copyright © 2019 Timmy Waters Software. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = testData[itemIndex]
    }
}
