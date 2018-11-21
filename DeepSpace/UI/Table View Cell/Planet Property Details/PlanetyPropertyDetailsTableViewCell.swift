//
//  PlanetyPropertyDetailsTableViewCell.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 20/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class PlanetyPropertyDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var propertyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
