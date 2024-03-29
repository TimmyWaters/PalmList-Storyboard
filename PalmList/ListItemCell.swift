//
//  ListItemCell.swift
//  PalmList
//
//  Created by Timothy Waters on 1/6/19.
//  Copyright © 2019 Timmy Waters Software. All rights reserved.
//

import UIKit

protocol ListItemCellDelegate {
    func setPriorityLevel(cell: ListItemCell)
    func setChecked(cell: ListItemCell)
}


class ListItemCell: UITableViewCell {
    
    @IBOutlet weak var priorityButton: UIButton!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var delegate: ListItemCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        self.delegate?.setPriorityLevel(cell: self)
    }
    
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        self.delegate?.setChecked(cell: self)
    }
}
