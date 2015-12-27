//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by andre trosky on 21/12/2015.
//  Copyright © 2015 andre trosky. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    // MARK: properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
