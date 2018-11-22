//
//  HomeScreenViewController.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 21/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    var navigationBarView: HomeScreenNavigationBarView!
    var gradientColors = [UIColor(rgb: 0x0088FF).cgColor, UIColor(rgb: 0x9911AA).cgColor]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarView = HomeScreenNavigationBarView(frame: self.navigationController!.navigationBar.frame)
        navigationBarView.titleLabel.text = "Deep Space"
        
        let menuOptionCellXIB = UINib(nibName: "MenuOptionsCollectionViewCell", bundle: Bundle.main)
        navigationBarView.menuCollectionView.register(menuOptionCellXIB, forCellWithReuseIdentifier: "optionCell")
        navigationBarView.setCollectionViewDataSourceDelegate(dataSourceDelegate: self)
        navigationBarView.contentView.frame = self.navigationController!.navigationBar.frame
        navigationBarView.frame.origin.y -= 40
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5) {
            self.navigationController?.navigationBar.addSubview(self.navigationBarView)
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }

}

extension HomeScreenViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "optionCell", for: indexPath) as? MenuOptionsCollectionViewCell
        
        if cell == nil {
            cell = MenuOptionsCollectionViewCell()
        }
        
        if indexPath.item == 0 {
            cell?.background.backgroundColor = UIColor.clear
            cell?.setGradient(colors: gradientColors, angle: -45.0)
        }
        
        cell?.layer.cornerRadius = 17
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.navigationBar.removeSubview(view: navigationBarView)
        navigationController?.navigationBar.prefersLargeTitles = false
        performSegue(withIdentifier: "Teste", sender: nil)
    }
    
}
