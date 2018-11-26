//
//  SolarSystemPlanetDetailsViewController.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 19/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var detailsTableView: UITableView!
    var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var headerImageExpandedScrollView: UIScrollView!
    var headerImageExpandedImageView: UIImageView!
    var closeImageExpandedButton: UIBarButtonItem!
    
    var image = UIImage(named: "picture.png")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        headerImageExpandedScrollView.backgroundColor = UIColor.black
        headerImageExpandedScrollView.isHidden = true
        headerImageExpandedScrollView.maximumZoomScale = 15
        headerImageExpandedScrollView.minimumZoomScale = 1
        headerImageExpandedScrollView.delegate = self
        headerImageExpandedScrollView.clipsToBounds = true
        headerImageExpandedScrollView.contentSize = self.view.bounds.size
        
        headerImageExpandedImageView = UIImageView(frame: self.view.bounds)
        headerImageExpandedImageView.contentMode = .scaleAspectFit
        headerImageExpandedImageView.clipsToBounds = false
        headerImageExpandedImageView.backgroundColor = UIColor.black
        headerImageExpandedImageView.image = image
        
        headerImageExpandedScrollView.addSubview(headerImageExpandedImageView)
        view.addSubview(headerImageExpandedScrollView)
        
        closeImageExpandedButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeImage(_:)))
        
        activityIndicator = UIActivityIndicatorView(frame: self.view.bounds)
        activityIndicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        activityIndicator.style = .whiteLarge
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
        
        if presentedModel == nil {
            activityIndicator.startAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
    }
    
    func expandImage() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Image Details"
        headerImageExpandedScrollView.isHidden = false
        navigationItem.rightBarButtonItem = closeImageExpandedButton
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @objc func closeImage(_ sender: UIBarButtonItem) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Details"
        headerImageExpandedScrollView.isHidden = true
        navigationItem.rightBarButtonItem = nil
        detailsTableView.reloadRows(at: [IndexPath(row: 0, section: 0)],
                                    with: .none)
        navigationItem.setHidesBackButton(false, animated: true)
    }
    
    func isTheCellWithCollectionView(tableViewRow: Int) -> Bool {
        return (tableViewRow == self.detailsTableView.numberOfRows(inSection: 0) - 1)
            && !planets.isEmpty
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

            cell?.headerImageView.image = self.image
            self.headerImageExpandedImageView.image = self.image
            
            if self.image != UIImage(named: "picture.png") {
                cell?.headerImageView.backgroundColor = UIColor.black
                if presentedModel is APOD {
                    cell?.headerImageView.contentMode = .scaleAspectFill
                }
            }
            
            return cell!
            
        } else if !isTheCellWithCollectionView(tableViewRow: indexPath.row) {
            var cell = self.detailsTableView.dequeueReusableCell(withIdentifier: "planetDetails", for: indexPath) as? PlanetPropertyDetailsTableViewCell
            
            if cell == nil {
                cell = PlanetPropertyDetailsTableViewCell()
            }
            
            if let propertiesArray = presentedModel?.toArray() {
                cell?.propertyLabel.text = propertiesArray[indexPath.row - 1].property
                cell?.valueLabel.text = propertiesArray[indexPath.row - 1].value
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
            
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row == 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return self.view.bounds.height * 0.3
        } else if !isTheCellWithCollectionView(tableViewRow: indexPath.row) {
            return UITableView.automaticDimension
        } else {
            return cellSize!.height + 16
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.expandImage()
        }
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
        
        cell?.contentView.layer.cornerRadius = 13
        cell?.contentView.layer.borderWidth = 1.0
        cell?.contentView.layer.borderColor = UIColor.clear.cgColor
        cell?.contentView.layer.masksToBounds = true
        
        cell?.layer.shadowColor = UIColor.black.cgColor
        cell?.layer.shadowOffset = CGSize(width: 1, height: 2)
        cell?.layer.shadowRadius = 0
        cell?.layer.shadowOpacity = 0.5
        cell?.layer.masksToBounds = false
        cell?.layer.shadowPath = UIBezierPath(roundedRect: cell!.bounds, cornerRadius: cell!.contentView.layer.cornerRadius).cgPath
        cell?.layer.backgroundColor = UIColor.clear.cgColor
        
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
