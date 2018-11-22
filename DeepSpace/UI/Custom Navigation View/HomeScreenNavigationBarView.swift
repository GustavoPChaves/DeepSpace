//
//  HomeScreenNavigationBarView.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 21/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class HomeScreenNavigationBarView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    public func commonInit() {
        Bundle.main.loadNibNamed("HomeScreenNavigationBarView", owner: self, options: nil)
        self.addSubview(contentView)
    }
    
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D) {
        
        menuCollectionView.delegate = dataSourceDelegate
        menuCollectionView.dataSource = dataSourceDelegate
        menuCollectionView.reloadData()
    }
    
}
