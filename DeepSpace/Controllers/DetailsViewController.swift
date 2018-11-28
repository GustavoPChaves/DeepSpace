//
//  SolarSystemPlanetDetailsViewController.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 19/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit
import SceneKit
import CoreMotion

class DetailsViewController: UIViewController, BackgroundDefault {

    @IBOutlet weak var backgroundSceneView: SCNView!
    var motionManager: CMMotionManager = CMMotionManager()
    
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var headerImageExpandedScrollView: UIScrollView!
    var headerImageExpandedImageView: UIImageView!
    var closeImageExpandedButton: UIBarButtonItem!
    
    lazy private var activityIndicator : CustomActivityIndicatorView! = {
        let image : UIImage = UIImage(named: "Loading.png")!
        return CustomActivityIndicatorView(image: image)
    }()
    
    var image = UIImage(named: "picture.png") {
        didSet {
            if let tableView = detailsTableView {
                tableView.reloadData()
            }
        }
    }
    
    var presentedModel : ConvertibleToArray? {
        didSet {
            if let activityIndicator = activityIndicator {
                activityIndicator.stopAnimating()
            }
        }
    }
    
    let allPlanets : [SolarSystemBodies] = [.mercury, .venus, .earth, .mars, .jupiter, .saturn, .uranus, .neptune, .pluto]
    var planets : [SolarSystemBodies] = []
    var cellSize : CGSize?
    @IBOutlet weak var gradientLayerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackground(myScene: backgroundSceneView)
        
        self.detailsTableView.dataSource = self
        self.detailsTableView.delegate = self
        
        let quarterOfScreenWidth = UIScreen.main.bounds.size.width/4
        cellSize = CGSize(width: quarterOfScreenWidth, height: 1.33 * quarterOfScreenWidth)
        
        let imageHeaderXIB = UINib(nibName: "ImageHeaderTableViewCell", bundle: Bundle.main)
        self.detailsTableView.register(imageHeaderXIB, forCellReuseIdentifier: "imageHeader")
        
        let planetDetailsXIB = UINib(nibName: "PlanetPropertyDetailsTableViewCell", bundle: Bundle.main)
        self.detailsTableView.register(planetDetailsXIB, forCellReuseIdentifier: "planetDetails")
        
        let otherPlanetsXIB = UINib(nibName: "OtherPlanetsTableViewCell", bundle: Bundle.main)
        self.detailsTableView.register(otherPlanetsXIB, forCellReuseIdentifier: "otherPlanets")
        
        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.estimatedRowHeight = 50
        detailsTableView.backgroundColor = UIColor.clear
        
        self.view.blurredView(withFrame: self.view.bounds,
                              opacity: 0.7,
                              backgroundColor: UIColor(red: 0,
                                                       green: 0,
                                                       blue: 0,
                                                       alpha: 0.4),
                              insertAt: 1)
        
        headerImageExpandedScrollView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        headerImageExpandedScrollView.isHidden = true
        headerImageExpandedScrollView.maximumZoomScale = 15
        headerImageExpandedScrollView.minimumZoomScale = 1
        headerImageExpandedScrollView.delegate = self
        headerImageExpandedScrollView.clipsToBounds = true
        headerImageExpandedScrollView.contentSize = self.view.bounds.size
        
        headerImageExpandedImageView = UIImageView(frame: self.headerImageExpandedScrollView.bounds)
        headerImageExpandedImageView.contentMode = .scaleAspectFit
        headerImageExpandedImageView.clipsToBounds = false
        headerImageExpandedImageView.backgroundColor = UIColor.clear
        headerImageExpandedImageView.image = image
        
        headerImageExpandedScrollView.addSubview(headerImageExpandedImageView)
        view.addSubview(headerImageExpandedScrollView)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapImageGestureHandler(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        headerImageExpandedScrollView.addGestureRecognizer(doubleTapGesture)
        
        closeImageExpandedButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeImage(_:)))
        
        activityIndicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(activityIndicator)
        
        if presentedModel == nil {
            activityIndicator.startAnimating()
        }
        
        detailsTableView.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityIndicator.positionate(inCenter: view.center,
                                      withSize: view.frame.size)
        centerImageOnScrollView(headerImageExpandedScrollView)
        self.backgroundSceneView.frame = self.view.bounds
        
        if headerImageExpandedScrollView.isHidden {
            let bounds = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 36.5)
            self.gradientLayerView.gradientLayer(colors: [UIColor(red: 0,
                                                                  green: 0,
                                                                  blue: 0,
                                                                  alpha: 0.75).cgColor,
                                                          UIColor.clear.cgColor],
                                                bounds: bounds,
                                                insertAt: 0)
        } else {
            let imageY = headerImageExpandedScrollView.frame.height/2 - headerImageExpandedImageView.frame.height/2
            headerImageExpandedImageView.frame.origin.y = imageY
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.transparent()
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor(rgb: 0xFF7700)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func expandImage() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Image Details"
        headerImageExpandedScrollView.isHidden = false
        navigationItem.rightBarButtonItem = closeImageExpandedButton
        navigationItem.setHidesBackButton(true, animated: true)
        detailsTableView.isHidden = true
    }
    
    @objc func closeImage(_ sender: UIBarButtonItem) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Details"
        headerImageExpandedScrollView.isHidden = true
        navigationItem.rightBarButtonItem = nil
        detailsTableView.reloadRows(at: [IndexPath(row: 0, section: 0)],
                                    with: .none)
        navigationItem.setHidesBackButton(false, animated: true)
        detailsTableView.isHidden = false
    }
    
    func isTheCellWithCollectionView(tableViewRow: Int) -> Bool {
        return (tableViewRow == self.detailsTableView.numberOfRows(inSection: 0) - 1)
            && !planets.isEmpty
    }
    
    @objc func openLinkInSafari(_ link: String) {
        activityIndicator.startAnimating()
        let workitem = DispatchWorkItem {
            let url = URL(string: link)!
            UIApplication.shared.open(url, options: [:]) { _ in
                self.activityIndicator.stopAnimating()
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            workitem.perform()
        }
    }
    
    @objc func doubleTapImageGestureHandler(_ sender: UITapGestureRecognizer) {
        if headerImageExpandedScrollView.zoomScale >= 6.0 {
            headerImageExpandedScrollView.setZoomScale(0.0, animated: true)
        } else {
            headerImageExpandedScrollView.setZoomScale(6.0, animated: true)
        }
    }
    
    func centerImageOnScrollView(_ scrollView: UIScrollView) {
        let subView = headerImageExpandedImageView
        let offsetX = max(((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5), 0.0)
        let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0)
        // adjust the center of image view
        subView?.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX,
                                  y: scrollView.contentSize.height * 0.5 + offsetY)
    }
    
}

extension DetailsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 1
        if !planets.isEmpty { count += 1 }
        if let propertiesArray = self.presentedModel?.toArray() { count += propertiesArray.count }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            var cell = self.detailsTableView.dequeueReusableCell(withIdentifier: "imageHeader", for: indexPath) as? ImageHeaderTableViewCell

            if cell == nil {
                cell = ImageHeaderTableViewCell()
            }

            cell?.selectionStyle = .none
            cell?.headerImageView.image = self.image
            self.headerImageExpandedImageView.image = self.image
            cell?.headerImageView.layer.cornerRadius = 13
            cell?.backgroundColor = UIColor.clear
            
            let height = cell!.bounds.height
            let width = cell!.bounds.width - 32
            let size = CGSize(width: width, height: height)
            let frame = CGRect(origin: cell!.headerImageView.frame.origin, size: size)

            let offset = CGSize(width: 0, height: 5)
            cell?.applyShadow(color: UIColor.black.withAlphaComponent(0.8).cgColor, offset: offset, layerFrame: frame)
            
            if self.image != UIImage(named: "picture.png") {
                cell?.headerImageView.backgroundColor = UIColor.black
                if presentedModel is APOD
                || presentedModel is DragonDTO
                || presentedModel is RocketsDTO
                || presentedModel is RoadsterDTO {
                    cell?.headerImageView.contentMode = .scaleAspectFill
                }
            } else {
                cell?.headerImageView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            }
            
            return cell!
            
        } else if !isTheCellWithCollectionView(tableViewRow: indexPath.row) {
            var cell = self.detailsTableView.dequeueReusableCell(withIdentifier: "planetDetails", for: indexPath) as? PlanetPropertyDetailsTableViewCell
            
            if cell == nil {
                cell = PlanetPropertyDetailsTableViewCell()
            }
            
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.clear
            if let propertiesArray = presentedModel?.toArray() {
                let property = propertiesArray[indexPath.row - 1].property
                cell?.propertyLabel.text = property
                
                let value = propertiesArray[indexPath.row - 1].value
                cell?.valueLabel.text = value
                
                if property == "Link" {
                    cell?.valueLabel.textColor = UIColor(rgb: 0x3478F6)
                } else {
                    cell?.valueLabel.textColor = UIColor.white
                }
                
            }
            
            return cell!
        } else {
            var cell = self.detailsTableView.dequeueReusableCell(withIdentifier: "otherPlanets", for: indexPath) as? OtherPlanetsTableViewCell
            
            if cell == nil {
                cell = OtherPlanetsTableViewCell()
            }
            
            let anotherPlanetXIB = UINib(nibName: "PlanetCollectionViewCell", bundle: Bundle.main)
            cell?.otherPlanetsCollectionView.register(anotherPlanetXIB, forCellWithReuseIdentifier: "planetThumb")
            cell?.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            
            cell?.backgroundColor = UIColor.clear
            cell?.otherPlanetsCollectionView.backgroundColor = UIColor.clear
            
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return (self.view.bounds.width - 32) * 1.33
        } else if !isTheCellWithCollectionView(tableViewRow: indexPath.row) {
            return UITableView.automaticDimension
        } else {
            return cellSize!.height + 16
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && self.image != UIImage(named: "picture.png") {
            self.expandImage()
            tableView.reloadRows(at: [indexPath], with: .none)
            return
        }
        
        let modelArray = presentedModel!.toArray()
        let model = modelArray[indexPath.row - 1]
        
        if model.property == "Link"
        || model.value.starts(with: "http://") {
            self.openLinkInSafari(model.value)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerImageOnScrollView(scrollView)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return headerImageExpandedImageView
    }
    
}

extension DetailsViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "planetThumb", for: indexPath) as? PlanetCollectionViewCell
        
        if cell == nil {
            cell = PlanetCollectionViewCell()
        }
        
        let imageName = planets[indexPath.item].rawValue.replacingOccurrences(of: "/", with: "")
        cell?.planetImage.image = UIImage(named: "\(imageName).jpg")
        cell?.planetNameLabel.text = imageName
        
        cell?.layer.cornerRadius = 13
        cell?.planetImage.backgroundColor = UIColor.black
        
        let offset = CGSize(width: 0, height: 5)
        cell?.applyShadow(offset: offset, layerFrame: cell!.bounds)
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let planet = planets[indexPath.item]
        self.detailsTableView.contentOffset.y = 0.0
        self.activityIndicator.startAnimating()
        
        SolarSystemAPI.getBody(planet) { planetObject in
            DispatchQueue.main.sync {
                self.planets = self.allPlanets.filter { $0 != planet }
                self.presentedModel = planetObject
                
                let imageName = planet.rawValue.replacingOccurrences(of: "/", with: "")
                if let image = UIImage(named: "\(imageName).jpg") {
                    self.image = image
                } else {
                    self.image = UIImage(named: "picture.png")
                }
                
                self.detailsTableView.reloadData()
                if self.activityIndicator.isAnimating {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
}
