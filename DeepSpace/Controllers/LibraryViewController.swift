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
    
    var selectedMenuOption = 0
    
    var menuOptions = ["Solar System", "APOD", "Exoplanets", "Minor Planets", "Dragons", "Rockets", "Roadster"]
    let allPlanets : [SolarSystemBodies] = [.mercury, .venus, .earth, .mars, .jupiter, .saturn, .uranus, .neptune, .pluto]
    var apods: [APOD] = []
    var exoplanets: [Exoplanet] = []
    var minorPlanets: [MinorPlanet] = []
    var dragons: [DragonDTO] = []
    var rockets: [RocketsDTO] = []
    var roadster: RoadsterDTO?
    
    var apodsIsRequesting = false
    var exoplanetsIsRequesting = false
    var minorPlanetsIsRequesting = false
    var dragonsIsRequesting = false
    var rocketsIsRequesting = false
    var roadsterIsRequesting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
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
        gradientLayerNavigationBar.frame.size.width = self.view.bounds.width
        gradientLayerNavigationBar.frame.origin.y = navigationBarView.getContentHeight()
        gradientLayerNavigationBar.backgroundColor = UIColor.clear
        
        let sublayer = UIView.getGradient(colors: [UIColor(red: 0,
                                                           green: 0,
                                                           blue: 0,
                                                           alpha: 0.75).cgColor, UIColor.clear.cgColor],
                                          bounds: gradientLayerNavigationBar.bounds)
        gradientLayerNavigationBar.layer.insertSublayer(sublayer, at: 0)
        
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
        
        var loadingCenter = view.center
        loadingCenter.y -= navBarHeight - 32
        
        activityIndicator.positionate(inOriginY: navBarHeight,
                                      inCenter: loadingCenter,
                                      withSize: contentCollectionView.frame.size)
        
        self.navigationBarView.blurredView(withFrame: CGRect(x: 0,
                                                             y: 0,
                                                             width: self.navigationBarView.bounds.width,
                                                             height: navBarHeight),
                                           backgroundColor: UIColor(red: 0,
                                                                    green: 0,
                                                                    blue: 0,
                                                                    alpha: 0.25))
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
    
    func optionChanged(indexPath: IndexPath) {
        self.contentCollectionView.contentOffset.y = 0
        self.selectedMenuOption = indexPath.item
        self.navigationBarView.menuCollectionView.reloadData()
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
        case 4:
            self.loadDragonsContent()
        case 5:
            self.loadRocketsContent()
        case 6:
            self.loadRoadsterContent()
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
    
    func loadDragonsContent() {
        if dragonsIsRequesting || dragons.isEmpty {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
        if !dragonsIsRequesting
            && dragons.isEmpty {
            activityIndicator.startAnimating()
            self.dragonsIsRequesting = true
            SpaceXAPIManager.requestDragons { dragons in
                DispatchQueue.main.async {
                    self.dragons = dragons
                    self.contentCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.dragonsIsRequesting = false
                }
            }
        } else {
            self.contentCollectionView.reloadData()
        }
    }
    
    func loadRocketsContent() {
        if rocketsIsRequesting || rockets.isEmpty {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
        if !rocketsIsRequesting
            && rockets.isEmpty {
            activityIndicator.startAnimating()
            self.rocketsIsRequesting = true
            SpaceXAPIManager.requestRockets { rockets in
                DispatchQueue.main.async {
                    self.rockets = rockets
                    self.contentCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.rocketsIsRequesting = false
                }
            }
        } else {
            self.contentCollectionView.reloadData()
        }
    }
    
    func loadRoadsterContent() {
        if roadsterIsRequesting || roadster == nil {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
        if !roadsterIsRequesting
            && roadster == nil {
            activityIndicator.startAnimating()
            self.roadsterIsRequesting = true
            SpaceXAPIManager.requestRoadster { roadster in
                DispatchQueue.main.async {
                    self.roadster = roadster
                    self.contentCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.roadsterIsRequesting = false
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
            case 4:
                return dragons.count
            case 5:
                return rockets.count
            case 6:
                return 1
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
            
            let bounds = CGRect(x: 0,
                                y: 0,
                                width: 150,
                                height: cell!.bounds.height)
            
            cell?.setupGradient(bounds: bounds)
            if indexPath.item == selectedMenuOption {
                cell?.showGradient()
                cell?.background.backgroundColor = UIColor.clear
            } else {
                cell?.hideGradient()
                cell?.background.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                
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
            case 4:
                sender = dragons[indexPath.item]
            case 5:
                sender = rockets[indexPath.item]
            case 6:
                sender = roadster
            default:
                break
            }
            
            self.performSegue(withIdentifier: identifier, sender: sender)
            
        } else {
            self.optionChanged(indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === contentCollectionView {
            switch selectedMenuOption {
            case 1, 4, 6:
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
        case 1, 4, 6:
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
