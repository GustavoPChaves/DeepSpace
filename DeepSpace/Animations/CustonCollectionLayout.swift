//
//  CustonCollectionLayout.swift
//  DeepSpace
//
//  Created by Adriel Freire on 26/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
import UIKit

class CustomCollectionLayout: UICollectionViewFlowLayout {
    var animator: UIDynamicAnimator?
    var attributes: [UICollectionViewLayoutAttributes] = []
    var prepared = false
    override init() {
        super.init()
        
        self.animator = UIDynamicAnimator(collectionViewLayout: self)
        
//        self.minimumInteritemSpacing = 10
        self.minimumLineSpacing = 30
        self.itemSize = CGSize(width: 200, height: 300)
//        self.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        
//        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        animator = UIDynamicAnimator(collectionViewLayout: self)
    }
    
    override func prepare() {
        
        
        let contentSize  = self.collectionView!.contentSize
        let items = layoutAttributesForElements(in: CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height))!
        
        if items.count == 0{
            
            super.prepare()
            
        }
        else{
            prepared = true
            if self.animator!.behaviors.count == 0{
                
                for item in items{
                    
                    let behavior = UIAttachmentBehavior(item: item, attachedToAnchor: item.center)
                    behavior.length = 0.5
                    behavior.damping = 0.3
                    behavior.frequency = 1
                    
                    self.animator!.addBehavior(behavior)
                }
            }
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        if prepared == false{
            
            return super.layoutAttributesForElements(in: rect)
        }
//
        let itens = self.animator!.items(in: rect)

        return (itens as! [UICollectionViewLayoutAttributes])
  

    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.animator!.layoutAttributesForCell(at:indexPath)
    }
    

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let scrollView = self.collectionView
        let delta = newBounds.origin.y - (scrollView?.bounds.origin.y)!
        let touchLocation = self.collectionView?.panGestureRecognizer.location(in: self.collectionView)
        
        let behaviors = self.animator!.behaviors as! [UIAttachmentBehavior]
        for behavior in behaviors{
            let xDistanceFromTouch = abs(touchLocation!.x - behavior.anchorPoint.x)
            let yDistanceFromTouch = abs(touchLocation!.y - behavior.anchorPoint.y)
            let scrollResistence = (xDistanceFromTouch + yDistanceFromTouch) / 1000
            
            let item = behavior.items.first
            var center = item?.center
            if(delta < 0){
                center!.y += max(delta, delta*scrollResistence)
            }else{
                center!.y -= min(delta, delta*scrollResistence)
            }
            item?.center = center!
            
            self.animator!.updateItem(usingCurrentState: item!)
        }
        
        return false
    }
    
}
