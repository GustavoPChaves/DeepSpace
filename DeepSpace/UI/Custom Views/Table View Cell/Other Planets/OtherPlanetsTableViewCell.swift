//
//  OtherPlanetsTableViewCell.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 20/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class OtherPlanetsTableViewCell: UITableViewCell {

    @IBOutlet weak var otherPlanetsCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        
        otherPlanetsCollectionView.delegate = dataSourceDelegate
        otherPlanetsCollectionView.dataSource = dataSourceDelegate
        otherPlanetsCollectionView.tag = row
        otherPlanetsCollectionView.reloadData()
    }
    
}
