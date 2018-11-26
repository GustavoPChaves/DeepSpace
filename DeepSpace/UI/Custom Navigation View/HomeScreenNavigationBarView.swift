//
//  HomeScreenNavigationBarView.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 21/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class HomeScreenNavigationBarView: UIView {
    
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var middleConstraint: NSLayoutConstraint!
    private var bottomConstraintConstant: CGFloat = 16
    
    @IBOutlet weak var contentView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    var isExpanded = true
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
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
        
        self.contentView.contentMode = .scaleAspectFill
        self.contentView.clipsToBounds = true
    }
    
    func collapse(font: UIFont = UIFont.systemFont(ofSize: 17, weight: .regular)) {
        titleLabel.textAlignment = .center
        titleLabelTopConstraint.constant = 8
        titleLabel.font = font
        middleConstraint.constant = 8
        bottomConstraintConstant = 8
        isExpanded = false
    }
    
    func expand(font: UIFont = UIFont.systemFont(ofSize: 34, weight: .bold)) {
        titleLabel.textAlignment = .left
        titleLabelTopConstraint.constant = 16
        titleLabel.font = font
        middleConstraint.constant = 16
        bottomConstraintConstant = 16
        isExpanded = true
    }
    
    func getContentHeight() -> CGFloat {
        return titleLabelTopConstraint.constant
            + titleLabel.frame.minY
            + titleLabel.frame.height
            + middleConstraint.constant
            + menuCollectionView.frame.height
            + bottomConstraintConstant
    }
    
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D) {
        
        menuCollectionView.delegate = dataSourceDelegate
        menuCollectionView.dataSource = dataSourceDelegate
        menuCollectionView.reloadData()
    }
    
}
