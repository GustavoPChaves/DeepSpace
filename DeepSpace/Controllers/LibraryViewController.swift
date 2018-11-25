//
//  LibraryViewController.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 21/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    var navigationBarView: HomeScreenNavigationBarView!
    var gradientLayer: CAGradientLayer!
    
    var gradientColors = [UIColor(rgb: 0x0088FF).cgColor,
                          UIColor(rgb: 0x9911AA).cgColor]
    
    var menuOptions = ["Solar System", "APOD", "Minor Planets", "Exoplanets"]
    
    var selectedMenuOption = 0
    let allPlanets : [SolarSystemBodies] = [.mercury, .venus, .earth, .mars, .jupiter, .saturn, .uranus, .neptune, .pluto]
    var apods: [APOD] = []
    
    var navigationBarHasBeenCollapsed = false
    var lastNavigationBarOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = UIActivityIndicatorView(frame: self.view.bounds)
        
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "universe.jpg")
        
        self.view.insertSubview(imageView, at: 0)
        
        navigationBarView = HomeScreenNavigationBarView(frame: self.navigationController!.navigationBar.frame)
        navigationBarView.titleLabel.text = "Deep Space"
        
        let menuOptionCellXIB = UINib(nibName: "MenuOptionsCollectionViewCell", bundle: Bundle.main)
        navigationBarView.menuCollectionView.register(menuOptionCellXIB, forCellWithReuseIdentifier: "optionCell")
        
        navigationBarView.setCollectionViewDataSourceDelegate(dataSourceDelegate: self)
        navigationBarView.contentView.frame = self.navigationController!.navigationBar.frame
        navigationBarView.frame.origin.y -= 40
        
        
        navigationBarView.contentView.backgroundColor = UIColor.clear
        navigationBarView.menuCollectionView.backgroundColor = UIColor.clear
        navigationBarView.backgroundColor = UIColor.clear
        self.contentCollectionView.backgroundColor = UIColor.clear
        
        let planetXIB = UINib(nibName: "PlanetCollectionViewCell", bundle: Bundle.main)
        contentCollectionView.register(planetXIB, forCellWithReuseIdentifier: "planetThumb")
        
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        activityIndicator.isHidden = true
        self.view.addSubview(activityIndicator)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addCustomNavigationBarView()
    }
    
    func addCustomNavigationBarView() {
        self.navigationController?.navigationBar.addSubview(self.navigationBarView)
        self.navigationController?.navigationBar.transparent()
    }
    
    func removeCustomNavigationBarView() {
        self.navigationController?.navigationBar.removeSubview(self.navigationBarView)
        self.navigationController?.navigationBar.removeTransparency()
    }
    
    func optionChanged(index: Int) {
        
        let removedGradientCell = self.navigationBarView.menuCollectionView.visibleCells[self.selectedMenuOption] as? MenuOptionsCollectionViewCell
        let addedGradientCell = self.navigationBarView.menuCollectionView.visibleCells[index] as? MenuOptionsCollectionViewCell
        
        removedGradientCell?.background.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        addedGradientCell?.background.backgroundColor = UIColor.clear
        
        UIView.animate(withDuration: 0.6) {
            self.contentCollectionView.contentOffset.y = 0
            if self.selectedMenuOption != index {
                removedGradientCell?.removeGradient(layer: self.gradientLayer)
                self.gradientLayer = addedGradientCell?.setGradient(colors: self.gradientColors, angle: 45.0)
                self.selectedMenuOption = index
            }
        }
        
        self.reloadContent()
    }
    
    func reloadContent() {
        switch selectedMenuOption {
        case 0:
            if activityIndicator.isAnimating { activityIndicator.stopAnimating() }
            self.contentCollectionView.reloadData()
        case 1:
            if apods.count < 31 {
                if apods.isEmpty {
                    activityIndicator.isHidden = false
                    activityIndicator.startAnimating()
                }
                
                NasaAPOD.getAPODsOfTheMonth(hd: false) { apod in
                    DispatchQueue.main.async {
                        let isAlreadyInArray = self.apods.contains { $0.title == apod.title }
                        if !isAlreadyInArray { self.apods.append(apod) }
                        self.contentCollectionView.reloadData()
                        self.activityIndicator.stopAnimating()
                    }
                }
            } else {
                self.contentCollectionView.reloadData()
            }
        default:
            self.contentCollectionView.reloadData()
        }
        
    }

}

extension LibraryViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === contentCollectionView {
            switch selectedMenuOption {
            case 0:
                return allPlanets.count
            case 1:
                return apods.count
            default:
                return 0
            }
        } else {
            return menuOptions.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === contentCollectionView {
            return buildCollectionViewContent(collectionView: collectionView, indexPath: indexPath)
            
        } else {
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "optionCell", for: indexPath) as? MenuOptionsCollectionViewCell
            
            if cell == nil {
                cell = MenuOptionsCollectionViewCell()
            }
            
            if indexPath.item == 0 {
                cell?.background.backgroundColor = UIColor.clear
                gradientLayer = cell?.setGradient(colors: gradientColors, angle: -45.0)
            }
            
            cell?.optionTitleLabel.text = menuOptions[indexPath.item]
            cell?.layer.cornerRadius = 17
            
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView === contentCollectionView {
            let identifier = "details"
            var sender : Any? = nil
            self.removeCustomNavigationBarView()
            
            switch selectedMenuOption {
            case 0:
                sender = allPlanets[indexPath.row]
            case 1:
                sender = apods[indexPath.row]
            default:
                break
            }
            
            self.performSegue(withIdentifier: identifier, sender: sender)
            
        } else {
            self.optionChanged(index: indexPath.item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === contentCollectionView {
            switch selectedMenuOption {
            case 1:
                let screenSize = UIScreen.main.bounds.size
                let cellWidth = screenSize.width - 32
                return CGSize(width: cellWidth, height: 1.33 * cellWidth)
            default:
                let screenSize = UIScreen.main.bounds.size
                let cellWidth = (screenSize.width - 32 - 10)/2
                return CGSize(width: cellWidth, height: 1.33 * cellWidth)
            }
        } else {
            let cellWidth = menuOptions[indexPath.item].widthOfString(usingFont: UIFont.systemFont(ofSize: 15)) + 16
            return CGSize(width: cellWidth, height: 36.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch selectedMenuOption {
        case 1:
            return 16
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension LibraryViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let location = scrollView.panGestureRecognizer.location(in: self.contentCollectionView)
        let indexPath = self.contentCollectionView.indexPathForItem(at: location)
        
        if indexPath != nil {
            let translationInY = scrollView.panGestureRecognizer.translation(in: self.contentCollectionView).y
            let isGoingDown = (translationInY > 0) ? false : true

            UIView.animate(withDuration: 0.5) {
                if isGoingDown && !self.navigationBarHasBeenCollapsed {
                    self.navigationBarView.titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
                    self.navigationBarView.titleLabel.textAlignment = .center
                    self.navigationItem.prompt = nil
                    self.navigationBarHasBeenCollapsed = true
                } else if !isGoingDown
                    && self.navigationBarHasBeenCollapsed
                    && scrollView.contentOffset.y < 17 {
                    self.navigationBarView.titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
                    self.navigationBarView.titleLabel.textAlignment = .left
                    self.navigationItem.prompt = " "
                    self.navigationBarHasBeenCollapsed = false
                }
                
            }
            
            
        }
    }
}
