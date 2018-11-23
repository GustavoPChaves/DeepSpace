//
//  CollectionTestViewController.swift
//  DeepSpace
//
//  Created by Adriel Freire on 21/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class CollectionTestViewController: UIViewController {
    @IBOutlet weak var myCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myCollection.delegate = self
        myCollection.dataSource = self
        
    }
    

}


extension CollectionTestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.backgroundImage.image = UIImage(named: "earth")
        cell.layer.borderWidth = 1
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        let frame = cell.backgroundImage.frame
        let image = UIImageView(frame: frame)
        image.center.x = cell.center.x
        image.center.y = cell.center.y
//        image.frame.origin.y = 0
        image.image = cell.backgroundImage.image
        self.view.addSubview(image)
        
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnc = NSLayoutConstraint(item: image, attribute: .top, relatedBy: .equal, toItem: cell, attribute: .top, multiplier: 1, constant: 0)
        let heightAnc = NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: cell, attribute: .height, multiplier: 1, constant: 0)
        let widthAnc = NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: cell, attribute: .width, multiplier: 1, constant: 0)
        let centerYAnc = NSLayoutConstraint(item: image, attribute: .centerY, relatedBy: .equal, toItem: cell, attribute: .centerY, multiplier: 1, constant: 0)
        let centerXAnc = NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: cell, attribute: .centerX, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([topAnc, heightAnc, widthAnc, centerYAnc, centerXAnc])
        
        
        UIView.animate(withDuration: 1.3) {
            widthAnc.constant = self.view.bounds.width
            heightAnc.constant = self.view.bounds.height
            
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
//            image.center.y = 0
//            topAnc.constant = 0
            
            topAnc.constant = -cell.center.y
            self.view.layoutIfNeeded()
            

        }) { (finished) in
            self.performSegue(withIdentifier: "next", sender: nil)
        }
        
    }
    
}

extension CollectionTestViewController: UIViewControllerTransitioningDelegate{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        destination.transitioningDelegate = self
        
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadePushAnimator()
    }
}
