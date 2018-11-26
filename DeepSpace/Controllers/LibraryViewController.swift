//
//  LibraryViewController.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 21/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    
    lazy private var activityIndicator : CustomActivityIndicatorView! = {
        let image : UIImage = UIImage(named: "Loading.png")!
        return CustomActivityIndicatorView(image: image)
    }()
    
    var navigationBarLargeTitleFont: UIFont?
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var navigationBarView: HomeScreenNavigationBarView!
    var gradientLayerNavigationBar: UIView!
    
    var gradientLayer: CAGradientLayer!
    
    var gradientColors = [UIColor(rgb: 0x0088FF).cgColor,
                          UIColor(rgb: 0x9911AA).cgColor]
    
    var selectedMenuOption = 0
    
    var menuOptions = ["Solar System", "APOD", "Exoplanets", "Minor Planets"]
    let allPlanets : [SolarSystemBodies] = [.mercury, .venus, .earth, .mars, .jupiter, .saturn, .uranus, .neptune, .pluto]
    var apods: [APOD] = []
    var exoplanets: [Exoplanet] = []
    var minorPlanets: [MinorPlanet] = []
    
    var apodsIsRequesting = false
    var exoplanetsIsRequesting = false
    var minorPlanetsIsRequesting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(activityIndicator)
        
        navigationBarLargeTitleFont = self.navigationController?.navigationBar.getNavigationBarFonts()[0]
        
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "universe.jpg")
        
        self.view.insertSubview(imageView, at: 0)
        
        navigationBarView.titleLabel.text = "Deep Space"
        navigationBarView.titleLabel.font = navigationBarLargeTitleFont
        self.navigationItem.title = nil
    
        let menuOptionCellXIB = UINib(nibName: "MenuOptionsCollectionViewCell", bundle: Bundle.main)
        navigationBarView.menuCollectionView.register(menuOptionCellXIB, forCellWithReuseIdentifier: "optionCell")
        
        navigationBarView.setCollectionViewDataSourceDelegate(dataSourceDelegate: self)
        navigationBarView.menuCollectionView.contentInset = contentCollectionView.contentInset
        
        navigationBarView.contentView.backgroundColor = UIColor.clear
        navigationBarView.menuCollectionView.backgroundColor = UIColor.clear
        navigationBarView.backgroundColor = UIColor.clear
        self.contentCollectionView.backgroundColor = UIColor.clear
        
        gradientLayerNavigationBar = UIView(frame: navigationBarView.menuCollectionView.frame)
        gradientLayerNavigationBar.frame.origin.y = navigationBarView.getContentHeight()
        gradientLayerNavigationBar.backgroundColor = UIColor.clear
        let _ = self.gradientLayerNavigationBar.setGradient(colors: [UIColor(red: 0, green: 0, blue: 0, alpha: 0.75).cgColor,
                                                            UIColor.clear.cgColor])
        self.view.addSubview(gradientLayerNavigationBar)
        self.view.bringSubviewToFront(self.contentCollectionView)
        
        let planetXIB = UINib(nibName: "PlanetCollectionViewCell", bundle: Bundle.main)
        contentCollectionView.register(planetXIB, forCellWithReuseIdentifier: "planetThumb")
        
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBarView.frame.origin.y = 0
        
        let navBarHeight = navigationBarView.getContentHeight()
        navigationBarView.frame.size.height = navBarHeight
        gradientLayerNavigationBar.frame.origin.y = navBarHeight
        contentCollectionView.frame.origin.y = navBarHeight
        contentCollectionView.frame.size.height = self.view.frame.height - navBarHeight
        
        activityIndicator.positionate(inOriginY: navBarHeight,
                                      inCenter: contentCollectionView.center,
                                      withSize: contentCollectionView.frame.size)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.clear]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.clear]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.isNavigationBarHidden = true
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
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
        if selectedMenuOption == index {
            UIView.animate(withDuration: 0.6) {
                self.contentCollectionView.contentOffset.y = 0
            }
            return
        }
        
        let removedIndexPath = IndexPath(item: selectedMenuOption, section: 0)
        let addedIndexPath = IndexPath(item: index, section: 0)
    
        let removedGradientCell = self.navigationBarView.menuCollectionView.cellForItem(at: removedIndexPath) as? MenuOptionsCollectionViewCell
        let addedGradientCell = self.navigationBarView.menuCollectionView.cellForItem(at: addedIndexPath) as? MenuOptionsCollectionViewCell
        
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
        self.contentCollectionView.reloadData()
        
        switch selectedMenuOption {
        case 0:
            activityIndicator.stopAnimating()
        case 1:
            self.loadAPODContent()
        case 2:
            self.loadExoplanetsContent()
        case 3:
            self.loadMinorPlanetsContent()
        default:
            break
        }
        
    }
    
    func loadAPODContent() {
        if apodsIsRequesting || apods.isEmpty {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
        if !apodsIsRequesting
            && apods.isEmpty {
            activityIndicator.startAnimating()
            self.apodsIsRequesting = true
            NasaAPOD.getAPODsOfTheMonth(hd: false) { apod in
                DispatchQueue.main.async {
                    let isAlreadyInArray = self.apods.contains { $0.title == apod.title }
                    if !isAlreadyInArray { self.apods.append(apod) }
                    self.contentCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.apodsIsRequesting = false
                }
            }
        } else {
            self.contentCollectionView.reloadData()
        }
    }
    
    func loadExoplanetsContent() {
        if exoplanetsIsRequesting || exoplanets.isEmpty {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
        if !exoplanetsIsRequesting
            && exoplanets.isEmpty {
            activityIndicator.startAnimating()
            self.exoplanetsIsRequesting = true
            NasaExoplanet.getExoplanetExtendedData { exoplanets in
                DispatchQueue.main.async {
                    self.exoplanets = exoplanets
                    self.contentCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.exoplanetsIsRequesting = false
                }
            }
        } else {
            self.contentCollectionView.reloadData()
        }
    }
    
    func loadMinorPlanetsContent() {
        if minorPlanetsIsRequesting || minorPlanets.isEmpty {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
        if !minorPlanetsIsRequesting
            && minorPlanets.isEmpty {
            activityIndicator.startAnimating()
            self.minorPlanetsIsRequesting = true
            MinorPlanetAPI.fetch { minorPlanets in
                DispatchQueue.main.async {
                    self.minorPlanets = minorPlanets
                    self.contentCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.minorPlanetsIsRequesting = false
                }
            }
        } else {
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
            case 2:
                return exoplanets.count
            case 3:
                return minorPlanets.count
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
            
            switch selectedMenuOption {
            case 0:
                sender = allPlanets[indexPath.item]
            case 1:
                sender = apods[indexPath.item]
            case 2:
                sender = exoplanets[indexPath.item]
            case 3:
                sender = minorPlanets[indexPath.item]
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

            UIView.animate(withDuration: 0.3) {
                if isGoingDown && self.navigationBarView.isExpanded {
                    self.navigationBarView.collapse()
                } else if !isGoingDown
                    && !self.navigationBarView.isExpanded
                    && scrollView.contentOffset.y < 30 {
                    self.navigationBarView.expand(font: self.navigationBarLargeTitleFont!)
                }
            }
            
        }
    }
}
