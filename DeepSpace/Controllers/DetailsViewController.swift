//
//  SolarSystemPlanetDetailsViewController.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 19/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var detailsTableView: UITableView!
    
    var image = UIImage(named: "picture.png") {
        didSet {
            if let imageView = self.planetImageView {
                imageView.image = image
            }
        }
    }
    
    var presentedModel : ConvertibleToArray? {
        didSet {
            if presentedModel is APOD {
                if let imageView = self.planetImageView {
                    imageView.contentMode = .scaleAspectFill
                }
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
        
        let planetDetailsXIB = UINib(nibName: "PlanetPropertyDetailsTableViewCell", bundle: Bundle.main)
        self.detailsTableView.register(planetDetailsXIB, forCellReuseIdentifier: "planetDetails")
        
        let otherPlanetsXIB = UINib(nibName: "OtherPlanetsTableViewCell", bundle: Bundle.main)
        self.detailsTableView.register(otherPlanetsXIB, forCellReuseIdentifier: "otherPlanets")
        
        self.planetImageView.image = image
        if image != UIImage(named: "picture.png") {
            self.planetImageView.backgroundColor = UIColor.black
        }

        if presentedModel is APOD {
            self.planetImageView.contentMode = .scaleAspectFill
        }
        
        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.estimatedRowHeight = 50
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func isTheCellWithCollectionView(tableViewRow: Int) -> Bool {
        return (tableViewRow == self.detailsTableView.numberOfRows(inSection: 0) - 1)
            && !planets.isEmpty
    }
    
    func collapseImageOnScroll(_ scrollView: UIScrollView) {
        let safeAreaY = (self.navigationController?.navigationBar.frame.size.height ?? 0) + UIApplication.shared.statusBarFrame.size.height
        let scrollOffset = scrollView.contentOffset.y
        let imageViewHeight = self.planetImageView.frame.size.height
        
        UIView.animate(withDuration: 0.2) {
            if scrollOffset > 100 {
                self.planetImageView.frame.origin.y = safeAreaY - imageViewHeight
                self.detailsTableView.frame.origin.y = safeAreaY
                self.detailsTableView.frame.size.height = self.view.frame.size.height - safeAreaY
            } else if scrollOffset == 0 {
                let tableY = safeAreaY + imageViewHeight
                self.planetImageView.frame.origin.y = safeAreaY
                self.detailsTableView.frame.origin.y = tableY
                self.detailsTableView.frame.size.height = self.view.frame.size.height - tableY
            }
        }
    }
    
}

extension DetailsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if !planets.isEmpty { count += 1 }
        if let propertiesArray = self.presentedModel?.toArray() { count += propertiesArray.count }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !isTheCellWithCollectionView(tableViewRow: indexPath.row) {
            var cell = self.detailsTableView.dequeueReusableCell(withIdentifier: "planetDetails", for: indexPath) as? PlanetPropertyDetailsTableViewCell
            
            if cell == nil {
                cell = PlanetPropertyDetailsTableViewCell()
            }
            
            if let propertiesArray = presentedModel?.toArray() {
                cell?.propertyLabel.text = propertiesArray[indexPath.row].property
                cell?.valueLabel.text = propertiesArray[indexPath.row].value
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !isTheCellWithCollectionView(tableViewRow: indexPath.row) {
            return UITableView.automaticDimension
        } else {
            return cellSize!.height + 16
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let location = scrollView.panGestureRecognizer.location(in: self.detailsTableView)
        let indexPath = self.detailsTableView.indexPathForRow(at: location)
        
        let lastRowIndex = self.detailsTableView.numberOfRows(inSection: 0) - 1
        if indexPath?.row == lastRowIndex { return }
        
        self.collapseImageOnScroll(scrollView)
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
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let planet = planets[indexPath.item]
        self.detailsTableView.contentOffset.y = 0.0
        SolarSystemAPI.getBody(planet) { planetObject in
            DispatchQueue.main.sync {
                self.planets = self.allPlanets.filter { $0 != planet }
                self.presentedModel = planetObject
                self.detailsTableView.reloadData()
                
                let imageName = planet.rawValue.replacingOccurrences(of: "/", with: "")
                if let image = UIImage(named: "\(imageName).jpg") {
                    self.image = image
                    self.planetImageView.image = image
                    self.planetImageView.backgroundColor = UIColor.black
                } else {
                    self.image = UIImage(named: "picture.png")
                    self.planetImageView.image = self.image
                    self.planetImageView.backgroundColor = UIColor.lightGray
                }
                
                self.detailsTableView.reloadData()
            }
        }
    }
    
}
