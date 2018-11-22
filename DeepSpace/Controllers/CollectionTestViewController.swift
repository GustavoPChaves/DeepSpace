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
    
    
}
