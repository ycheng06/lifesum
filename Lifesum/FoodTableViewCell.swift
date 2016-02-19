//
//  FoodTableViewCell.swift
//  Lifesum
//
//  Created by Jason Cheng on 2/18/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var servingLabel: UILabel!
    @IBOutlet weak var gramsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
