//
//  CustomCollectionViewLayout.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 22/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

protocol CustomCollectionViewLayoutDelegate: class {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
}

class CustomCollectionViewLayout: UICollectionViewLayout {
    weak var delegate: CustomCollectionViewLayoutDelegate!
    
    fileprivate var numberOfLines = 1
    fileprivate var cellPadding: CGFloat = 8
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    fileprivate var contentWidth: CGFloat = 0
    
    fileprivate var contentHeight: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.top + insets.bottom)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        
        let columnHeight = contentHeight / CGFloat(numberOfLines)
        var yOffset = [CGFloat]()
        for line in 0 ..< numberOfLines {
            yOffset.append(CGFloat(line) * columnHeight)
        }
        var line = 0
        var xOffset = [CGFloat](repeating: 0, count: numberOfLines)
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            // 4
            let photoWidth = delegate.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath)
            let width = cellPadding * 2 + photoWidth
            let frame = CGRect(x: xOffset[line], y: yOffset[line], width: width, height: columnHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // 6
            contentWidth = max(contentWidth, frame.maxX)
            xOffset[line] = xOffset[line] + width
            
            line = line < (numberOfLines - 1) ? (numberOfLines + 1) : 0
        }
    }
    
}
