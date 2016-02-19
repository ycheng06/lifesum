//
//  ExerciseTableViewCell.swift
//  Lifesum
//
//  Created by Jason Cheng on 2/18/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
